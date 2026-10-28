// Service worker de Pechera: instalable y abre aunque haya mala señal en la cancha.
const CACHE = 'pechera-v1';
const SHELL = ['/pechera/', '/pechera/index.html', '/pechera/manifest.webmanifest', '/pechera/icons/icon-192.png', '/pechera/icons/icon-512.png', '/pechera/icons/apple-touch-icon.png', '/pechera/icons/favicon.png'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) => Promise.all(keys.filter((k) => k.startsWith('pechera-') && k !== CACHE).map((k) => caches.delete(k)))).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);
  if (e.request.method !== 'GET' || url.origin !== location.origin || !url.pathname.startsWith('/pechera/')) return;
  // Primero la red (para recibir actualizaciones); sin señal, lo guardado.
  e.respondWith(
    fetch(e.request)
      .then((res) => {
        const copy = res.clone();
        caches.open(CACHE).then((c) => c.put(e.request, copy));
        return res;
      })
      .catch(() => caches.match(e.request).then((r) => r || caches.match('/pechera/index.html')))
  );
});
