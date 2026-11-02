---
name: Fueguitos
description: Hábitos con amigos; cada día anotado prende un fueguito.
colors:
  brasa: "#FF5A1F"
  brasa-honda: "#D9420C"
  brasa-honda-noche: "#E04A12"
  brasa-tinta: "#A8390A"
  brasa-tinta-noche: "#FF9466"
  brasa-suave: "#FFE6DA"
  brasa-suave-noche: "#3A2019"
  nucleo: "#FFB547"
  hielo: "#1A72A6"
  hielo-noche: "#4DB5EE"
  hielo-tinta: "#155E8A"
  hielo-tinta-noche: "#6CC3F2"
  hecho: "#1E8A55"
  hecho-noche: "#2FB673"
  hecho-tinta: "#16653F"
  hecho-tinta-noche: "#7DDBA8"
  hecho-suave: "#DFF2E7"
  hecho-suave-noche: "#15301F"
  peligro: "#C62F43"
  ceniza-fria: "#EEF0F4"
  superficie: "#FFFFFF"
  tinta-carbon: "#1D1B26"
  humo: "#5F5C6B"
  linea: "#DCDFE7"
  carbon-violaceo: "#15131B"
  superficie-noche: "#201D29"
  ceniza-clara: "#EDEAF3"
  humo-noche: "#A6A1B5"
  linea-noche: "#2F2B3B"
  brasa-apagada: "#C9CBD6"
  brasa-apagada-noche: "#4A4558"
typography:
  marcador:
    fontFamily: "Archivo, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "96px"
    fontWeight: 900
    lineHeight: 0.85
    letterSpacing: "-0.01em"
    fontVariation: "'wdth' 62"
    fontFeature: "tnum"
  racha:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "44px"
    fontWeight: 900
    lineHeight: 0.85
    letterSpacing: "-0.01em"
    fontVariation: "'wdth' 62"
    fontFeature: "tnum"
  headline:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "30px"
    fontWeight: 800
    lineHeight: 1.1
    letterSpacing: "-0.01em"
  title:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "20px"
    fontWeight: 800
    lineHeight: 1.1
  habito:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 700
    lineHeight: 1.2
  body:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.4
    fontVariation: "'wdth' 100"
  label:
    fontFamily: "Archivo, system-ui, sans-serif"
    fontSize: "14px"
    fontWeight: 700
    lineHeight: 1.3
rounded:
  sm: "12px"
  md: "14px"
  lg: "18px"
  sheet: "26px"
  full: "999px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  xl: "22px"
components:
  button-primary:
    backgroundColor: "{colors.brasa}"
    textColor: "{colors.tinta-carbon}"
    rounded: "{rounded.md}"
    padding: "0 20px"
    height: "52px"
  button-small:
    rounded: "{rounded.sm}"
    padding: "0 14px"
    height: "44px"
  button-ghost:
    backgroundColor: "{colors.superficie}"
    textColor: "{colors.tinta-carbon}"
    rounded: "{rounded.md}"
    height: "52px"
  button-ice:
    backgroundColor: "{colors.hielo}"
    textColor: "{colors.superficie}"
    rounded: "{rounded.md}"
    height: "52px"
  habit-row:
    backgroundColor: "{colors.superficie}"
    rounded: "{rounded.lg}"
    padding: "14px 10px 14px 8px"
  habit-check:
    rounded: "{rounded.full}"
    size: "48px"
  newsline:
    backgroundColor: "{colors.superficie}"
    textColor: "{colors.tinta-carbon}"
    rounded: "{rounded.md}"
    padding: "12px 14px"
  chip:
    backgroundColor: "{colors.superficie}"
    rounded: "{rounded.full}"
    padding: "8px 14px"
  chip-on:
    backgroundColor: "{colors.tinta-carbon}"
    textColor: "{colors.ceniza-fria}"
    rounded: "{rounded.full}"
  card:
    backgroundColor: "{colors.superficie}"
    rounded: "{rounded.lg}"
    padding: "16px"
---

# Design System: Fueguitos

## Overview

**Creative North Star: "Fogón de noche"**

Hoy se lee como un fogón visto de cerca: un marcador grande que dice cuántos hábitos van prendidos, una fila de brasas (una por hábito) y abajo la lista de lo que falta y lo ya prendido. Todo vive en tokens de `:root` dentro de `index.html`; el modo oscuro (carbón violáceo) es el modo de primera, porque la app se usa de noche antes del corte de las 5 AM. El modo claro es ceniza fría con tinta carbón, nunca crema.

La densidad es de app de una mano: filas anchas, blancos de toque de 44 a 52 px, una sola superficie por hábito con divisores finos. El naranja brasa es el fuego y la acción principal; el resto de la pantalla es neutro para que el fuego se note. Los números de racha y el marcador usan Archivo condensado y negro, como un tablero deportivo; el texto corre en ancho normal.

**Alcance honesto.** El rediseño "Fogón" está aplicado en la pestaña **Hoy**. Amigos, Rutinas y Perfil heredan los tokens (colores, tipografía, botones planos, tarjetas) pero todavía usan los patrones de tarjeta anteriores (tarjetas con borde de 2 px, anillos en otras vistas, encabezados con emoji). Al tocarlas, llevarlas a los patrones de abajo, no al revés.

**Key Characteristics:**
- Oscuro de primera, claro en ceniza fría; ambos con los mismos roles.
- Una brasa, un uso: fuego y acción principal.
- Números condensados (ancho 62) y negros para rachas y marcador.
- Superficies planas con sombra suave; nada de sombras desplazadas.
- Una sola ignición animada como momento de festejo.

## Colors

Neutros fríos violáceos, una brasa naranja con núcleo dorado, y acentos funcionales (hielo azul, hecho verde, peligro rojo). Cada rol tiene su par claro / noche en el frontmatter.

### Primary
- **Brasa** (`brasa`): el fuego encendido, el botón principal, el punto de Novedades y la selección de texto. El texto sobre brasa es tinta carbón, no blanco.
- **Brasa honda** (`brasa-honda` / `brasa-honda-noche`): el número grande del marcador en modo claro (en oscuro el marcador usa la brasa pura) y estados presionados.
- **Brasa tinta** (`brasa-tinta` / `brasa-tinta-noche`): brasa usada como texto ("Te falta hoy", "Ver", pestaña activa). Siempre esta variante para texto, nunca la brasa pura sobre claro.
- **Brasa suave** (`brasa-suave` / `brasa-suave-noche`): fondo de una fila de hábito seleccionada.
- **Núcleo** (`nucleo`): solo el corazón interior del dibujo de la llama.

### Secondary
- **Hielo** (`hielo` / `hielo-noche`), con **hielo tinta** para links: hielitos, diamantes, foco del teclado (anillo de 3 px) y acciones secundarias.

### Tertiary
- **Hecho** (`hecho`, `hecho-tinta`, `hecho-suave`, en par claro / noche): marcador completo ("Día completo"), estados "Anotado hoy".
- **Peligro** (`peligro`): fallado, borrar.

### Neutral
- **Ceniza fría / Carbón violáceo** (`ceniza-fria` / `carbon-violaceo`): fondo de página.
- **Superficie** (`superficie` / `superficie-noche`): filas, tarjetas, línea de Novedades.
- **Tinta carbón / Ceniza clara** (`tinta-carbon` / `ceniza-clara`): texto principal.
- **Humo** (`humo` / `humo-noche`): fechas, "días", texto secundario, el "/4" del marcador.
- **Línea** (`linea` / `linea-noche`): bordes de 1 px y divisores.
- **Brasa apagada** (`brasa-apagada` / `brasa-apagada-noche`): llamas sin prender en la fila de brasas.

### Color por hábito
Cada hábito tiene su color (`--hc`), elegido por la persona o deducido del nombre, de una paleta fija de ocho: Naranja `#FF6A1F`, Rosa `#F06FA8`, Violeta `#9B6BFF`, Celeste `#4FB3E8`, Verde `#23A566`, Amarillo `#F2B705`, Rojo `#E5484D`, Gris `#8A8F98`. Se usa en el número de racha, el borde y relleno del círculo de anotar, y como tinte del 8% sobre la fila ya hecha.

### Named Rules
**The Una Brasa Rule.** El naranja brasa es para el fuego y la acción principal. No se usa como decoración, fondo de sección ni color de título.

**The Tinta Mezclada Rule.** Un color de hábito que se usa como texto o borde fino pasa por `--hcx` = mezcla del color del hábito con la tinta (`--hc-pct`: 62% en claro, 100% en oscuro). Así el amarillo o el celeste se leen sobre ceniza fría; de noche se usan puros. El relleno del círculo prendido sí usa el color puro, con el tilde en tinta carbón.

## Typography

**Fuente única:** Archivo variable (Google Fonts, ejes `wdth` 62–125 y `wght` 400–900), con `system-ui, -apple-system, "Segoe UI", sans-serif` de respaldo.

**Character:** una sola familia en dos anchos. Condensada y negra para los números, que tienen que leerse de un vistazo como un tanteador; ancho normal para todo lo que se lee.

### Hierarchy
- **Marcador** (900, 96 px, ancho 62, cifras tabulares, interlineado 0.85): el "2" de "2/4" en Hoy. El "/4" va a 44 px en humo.
- **Racha** (900, 44 px, ancho 62): el número de días a la izquierda de cada hábito, en `--hcx`. Baja a 32 px con cuatro cifras o cuando el hábito ya está hecho. Debajo, "días" a 12 px / 700 en humo.
- **Headline** (800, 30 px, -0.01em): títulos de pantalla. h2 a 22 px / 800.
- **Title** (800, 20 px): títulos de sección de Hoy ("Te falta", "Ya prendiste"). Texto plano, sin emoji.
- **Hábito** (700, 18 px; 16 px cuando ya está hecho): nombre del hábito, seguido del emoji que eligió la persona.
- **Body** (400, 16 px, 1.4).
- **Label** (700, 14–15 px): línea de estado del hábito, fecha, leyenda del marcador. Sin mayúsculas forzadas.

### Named Rules
**The Tanteador Rule.** Solo los números de racha y del marcador van condensados y en 900. El texto nunca se condensa.

## Layout

Columna única de máximo 480 px, centrada, con 16 px de margen lateral y espacio inferior para la barra de pestañas fija (más el área segura del iPhone). Arriba, una barra de estado pegajosa y translúcida (avatar, racha total, diamantes).

Orden de Hoy, de arriba abajo: fecha, marcador con la fila de brasas, "Te falta" con los pendientes, "Ya prendiste" con los hechos (filas más bajas), y Novedades en un renglón al final. Las filas de hábito se apilan con 10 px entre sí; las secciones se separan con 22 px arriba del título.

Ritmo de espaciado: 4 / 8 / 12 / 16 / 22 px. Blancos de toque mínimos: 48 px para anotar, 44 px para botones chicos y links de pie ("Deshacer", "¿Lo hiciste ayer?"), 52 px para botones grandes.

## Elevation & Depth

Plano con una sombra ambiente muy suave. La profundidad sale del contraste entre fondo y superficie, no de volúmenes.

### Shadow Vocabulary
- **Sombra ambiente** (claro: `0 1px 2px rgba(29,27,38,.06), 0 4px 14px rgba(29,27,38,.05)`; oscuro: `0 1px 2px rgba(0,0,0,.3), 0 6px 18px rgba(0,0,0,.25)`): filas de hábito y tarjetas.
- **Sombra flotante** (`0 8px 24px rgba(0,0,0,.2)`): solo el aviso con botones (snack) que flota sobre la barra.

### Named Rules
**The Sin Labio Rule.** Los botones no tienen sombra. Ninguna superficie lleva sombra desplazada y dura (el viejo "botón 3D"). Al presionar, el botón se achica (escala 0.97) y se oscurece un poco; no se hunde.

## Shapes

Esquinas generosas y redondas, bordes finos. Botones y campos 14 px (12 px los chicos), filas y tarjetas 18 px, hojas inferiores 26 px arriba, chips y círculos totalmente redondos. Bordes de 1 px en filas, tarjetas y Novedades; 1.5 px en botón fantasma y chips; 2.5 px en el aro del círculo de anotar.

## Components

### Fila de hábito (firma de Hoy)
- **Estructura:** una sola superficie por hábito: a la izquierda el número de racha (60 px de ancho) con "días" abajo, al centro nombre + emoji + una sola línea de estado, a la derecha el círculo de anotar. Los links de pie ("Deshacer", "¿Lo hiciste ayer? Anotalo", "Salvar con hielito") van en una franja inferior alineada con el texto, como píldoras de 44 px sobre el color de fondo.
- **Pendiente:** superficie, borde de línea, número en `--hcx`. Estado en brasa tinta ("Te falta hoy") o con la hora límite.
- **Seleccionada:** fondo brasa suave y borde brasa.
- **Hecha:** baja de altura (número a 32 px, nombre a 16 px, se ocultan pista y progreso) y toma un tinte del 8% del color del hábito.
- **Cantidades (vasos de agua):** suma barra de progreso y botones "+1" (primario) y "Todo ✓" (fantasma) dentro de la misma fila.

### Círculo de anotar
- **Forma:** círculo de 48 px, aro de 2.5 px en `--hcx`, vacío.
- **Prendido:** relleno con el color puro del hábito, tilde SVG en tinta carbón. Al tocarlo de nuevo, deshace.
- **Fallado:** relleno peligro.
- **Presionado:** escala 0.92.

### Marcador con brasas
- **Estructura:** número grande "N" + "/total" a la izquierda; a la derecha la fila de brasas (llamas de 24 × 30 px, una por hábito que cuenta hoy) y abajo la leyenda ("prendidos hoy", "Todavía no prendiste ninguno hoy", "Día completo").
- **Color:** número en brasa honda (claro) o brasa (oscuro); con el día completo, número y leyenda pasan a verde hecho.
- **Accesibilidad:** el conjunto es una imagen con etiqueta "Hoy: N de M hábitos anotados"; las piezas internas se ocultan del lector.
- **Movimiento:** ver la Ignición Única abajo.

### Línea de Novedades
Un renglón tocable: punto brasa de 8 px, texto truncado con puntos suspensivos y "Ver" en brasa tinta. Superficie, borde de 1 px, radio 14 px. Reemplaza la tarjeta grande de novedades.

### Botones
- **Forma:** 14 px de radio, alto 52 px, ancho completo; los chicos 44 px y 12 px de radio. Texto 700, 17 px.
- **Primario:** brasa con texto tinta carbón.
- **Fantasma:** superficie, borde de 1.5 px en línea, texto tinta.
- **Hielo / Verde / Peligro:** fondo del rol con texto blanco.
- **Estados:** presionado escala 0.97 y brillo 0.95; deshabilitado al 55% de opacidad; foco con anillo hielo de 3 px.

### Chips
Píldoras de 8 × 14 px, borde de 1.5 px en línea, superficie, texto 700 a 15 px. Activo: fondo tinta, texto del color de fondo. Pueden llevar un contador redondo en brasa.

### Tarjetas
Superficie, radio 18 px, borde de 1 px en línea, 16 px de relleno, sombra ambiente. La tarjeta de semana usa radio 16 px y 12 × 14 px de relleno.

### Navegación
Barra inferior fija y translúcida (desenfoque 10 px) con cuatro pestañas: ícono SVG de trazo de 26 px y etiqueta de 12 px / 700 en humo; la activa en brasa tinta.

### Iconografía
Íconos dibujados en SVG en línea: llama de dos capas (brasa + núcleo, o dos grises cuando está apagada), tilde de trazo 3, diamante, y los íconos de pestaña con trazo 2.2 y puntas redondas. Los emojis aparecen solo como contenido de la persona (el emoji de cada hábito, reacciones), no como íconos de la interfaz.

### Movimiento
**The Ignición Única Rule.** En Hoy hay un solo festejo animado: cuando un hábito se anota, su brasa en el marcador se prende (0.75 s, `cubic-bezier(.16,1,.3,1)`: crece desde 0.3, pasa por 1.25 y se asienta, con un destello de brillo). Solo la brasa recién prendida se anima; si la pantalla se redibuja a mitad de camino, la animación sigue donde iba. Con `prefers-reduced-motion: reduce`, la brasa aparece prendida sin animación, y además una regla global apaga todas las animaciones y transiciones. Las transiciones de interfaz (hoja que sube en 0.22 s, avisos en 0.2 s) son funcionales, no festejos.

## Do's and Don'ts

### Do:
- **Do** usar los tokens de `:root` para todo color; nada de hex sueltos salvo la paleta de hábitos.
- **Do** mostrar rachas y marcador con números condensados (ancho 62, peso 900, cifras tabulares).
- **Do** pasar todo color de hábito usado como texto o borde por `--hcx` (Tinta Mezclada).
- **Do** usar brasa tinta, hielo tinta y hecho tinta cuando el color va como texto.
- **Do** mantener blancos de toque de 48 px para anotar y 44 px como mínimo para todo lo demás.
- **Do** probar cada pantalla en oscuro primero y en claro después.

### Don't:
- **Don't** usar sombras desplazadas y duras ni botones "3D" con labio.
- **Don't** usar fondo crema o beige; el claro es ceniza fría.
- **Don't** poner etiquetas pequeñas en mayúsculas encima de los títulos (eyebrows / kickers).
- **Don't** poner emoji en títulos ni usarlos como íconos de interfaz; los íconos se dibujan en SVG.
- **Don't** volver al anillo de progreso para el avance del día; el avance se cuenta con el marcador y las brasas.
- **Don't** animar más de un festejo a la vez ni ignorar `prefers-reduced-motion`.
- **Don't** usar la brasa como decoración o color de título.
