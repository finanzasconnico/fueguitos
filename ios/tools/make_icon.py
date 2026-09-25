"""Genera el ícono de la app (1024x1024, opaco) dibujando el fueguito del SVG de la app.

Uso: python ios/tools/make_icon.py  (desde la carpeta racha)
"""
import math, os, re
from PIL import Image, ImageDraw, ImageFilter

OUTER = "M32 2c4 16 22 24 22 48a22 22 0 0 1-44 0c0-12 6-20 12-26 0 8 4 12 8 12C28 22 28 12 32 2z"
INNER = "M32 40c3 8 12 11 12 22a12 12 0 0 1-24 0c0-6 4-10 6-12 0 4 2 6 4 6-1-6 0-12 2-16z"


def flatten(d, steps=40):
    """Convierte un path SVG (M, c/C, a, z) en una lista de puntos."""
    toks = re.findall(r"[MmCcAaZz]|-?\d*\.?\d+", d)
    pts, i, cur, cmd = [], 0, (0.0, 0.0), None
    num = lambda: float(toks[i])
    while i < len(toks):
        if re.match(r"[A-Za-z]", toks[i]):
            cmd = toks[i]; i += 1
            if cmd in "Zz":
                continue
        if cmd == "M":
            cur = (float(toks[i]), float(toks[i + 1])); i += 2; pts.append(cur); cmd = "L"
        elif cmd in "Cc":
            v = [float(t) for t in toks[i:i + 6]]; i += 6
            if cmd == "c":
                v = [v[k] + cur[k % 2] for k in range(6)]
            p0, p1, p2, p3 = cur, (v[0], v[1]), (v[2], v[3]), (v[4], v[5])
            for s in range(1, steps + 1):
                t = s / steps; u = 1 - t
                pts.append((u**3*p0[0] + 3*u*u*t*p1[0] + 3*u*t*t*p2[0] + t**3*p3[0],
                            u**3*p0[1] + 3*u*u*t*p1[1] + 3*u*t*t*p2[1] + t**3*p3[1]))
            cur = p3
        elif cmd in "Aa":
            r = float(toks[i]); i += 3; large, sweep = int(float(toks[i])), int(float(toks[i + 1])); i += 2
            x, y = float(toks[i]), float(toks[i + 1]); i += 2
            if cmd == "a":
                x, y = x + cur[0], y + cur[1]
            # Los arcos del fueguito son medias vueltas: el centro es el punto medio.
            cx, cy = (cur[0] + x) / 2, (cur[1] + y) / 2
            a0 = math.atan2(cur[1] - cy, cur[0] - cx)
            a1 = a0 + (math.pi if sweep else -math.pi)
            for s in range(1, steps + 1):
                a = a0 + (a1 - a0) * s / steps
                pts.append((cx + r * math.cos(a), cy + r * math.sin(a)))
            cur = (x, y)
        else:
            i += 1
    return pts


def make(size=1024, out="ios/App/Assets.xcassets/AppIcon.appiconset/icon-1024.png"):
    S = size * 4  # sobremuestreo para bordes suaves
    img = Image.new("RGB", (S, S), (23, 14, 11))
    # Fondo: brasa (radial cálido sobre casi negro)
    glow = Image.new("RGB", (S, S), (23, 14, 11))
    g = ImageDraw.Draw(glow)
    for k in range(60, 0, -1):
        f = k / 60
        col = tuple(int(a + (b - a) * (1 - f)) for a, b in zip((23, 14, 11), (120, 42, 14)))
        rr = S * 0.62 * f
        g.ellipse([S / 2 - rr, S * 0.56 - rr, S / 2 + rr, S * 0.56 + rr], fill=col)
    img = glow.filter(ImageFilter.GaussianBlur(S / 40))
    d = ImageDraw.Draw(img)
    # El SVG mide 64x80: se centra ocupando ~62% del alto.
    k = S * 0.62 / 80
    ox, oy = S / 2 - 32 * k, S / 2 - 40 * k + S * 0.01
    tr = lambda p: [(ox + x * k, oy + y * k) for x, y in p]
    d.polygon(tr(flatten(OUTER)), fill=(255, 90, 31))
    d.polygon(tr(flatten(INNER)), fill=(255, 184, 0))
    img = img.resize((size, size), Image.LANCZOS)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    img.save(out, "PNG")
    return out


if __name__ == "__main__":
    print(make())
