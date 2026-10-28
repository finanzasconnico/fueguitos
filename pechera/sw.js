// Pechera ahora es La Casaca: este service worker se da de baja solo.
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => {
  e.waitUntil(self.registration.unregister().then(() => self.clients.matchAll()).then((cs) => cs.forEach((c) => c.navigate('/lacasaca/'))));
});
