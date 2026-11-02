# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users
Grupos chicos de gente que se conoce: amigos, parejas, familia y compañeros de trabajo, en Argentina, de 20 a 35 años, mayormente con iPhone. Anotan sus hábitos en el día y, sobre todo, de noche antes de dormir (el día cuenta hasta las 5 AM). Hoy la usan conocidos; el plan es abrirla a cualquiera que quiera usarla con sus amigos, y más adelante publicarla en App Store.

## Product Purpose
Ayudar a sostener hábitos (deporte, lectura, agua, idiomas, dejar algo) con la ayuda de los amigos. Cada día anotado prende un fueguito y suma a la racha. Éxito es que la gente vuelva todos los días y que la racha dure, no que anote mucho.

## Positioning
Lo que la hace distinta de otras apps de hábitos:
- **Rachas compartidas:** la racha del grupo o de a dos suma solo si cumplen todos. Te cuidan y cuidás a los demás.
- **Ver a tus amigos:** quién anotó hoy, las fotos del día (duran 24 h) y quién está en la banca (más de 7 días sin anotar).
- **Anotar es un toque:** sin formularios. Hielitos que salvan la racha si un día no llegás.
- **El personaje que crece:** un huevito que nace al anotar y un muñequito que se viste con diamantes que se ganan anotando.

## Operating Context
- App web instalable (PWA) en un solo archivo `index.html`, con service worker (`sw.js`). Publicada en Vercel (fueguitos.vercel.app) y GitHub Pages. No está en las tiendas.
- Backend en Supabase: funciones `api_*` por RPC, notificaciones push con una función de borde.
- Se usa a una mano, muchas veces de noche y en modo oscuro.
- Comparte el repositorio con La Casaca DT (carpeta `lacasaca/`), una app hermana para equipos de fútbol y hockey.

## Capabilities and Constraints
- Pestañas: Hoy, Amigos, Rutinas y Perfil.
- Hábitos de hacer (con días fijos o "X veces por semana") y de dejar algo; hábitos libres sin racha; cantidades (vasos de agua), hora límite y hábitos "de la noche".
- Calendario de semana, mes y año; cada día se puede editar.
- Amigos, amigos de amigos, empujones, regalar hielitos, rachas en grupo y de a dos, desafíos, juegos y torneos.
- Detalle de deporte (varias actividades, km, minutos, gimnasio con rutinas y pesos) y gráficos de progreso.
- Personaje (huevito, animalitos, tienda con diamantes) y reacciones con emojis.
- Funciona sin señal: guarda lo anotado y lo sube cuando vuelve la conexión.
- Sin frameworks ni build: HTML, CSS y JavaScript a mano.

## Brand Commitments
- El nombre **Fueguitos** y el núcleo del producto (rachas, amigos, anotar con un toque) se mantienen.
- Español rioplatense, cercano y con humor ("¡Salvá tu fueguito!").
- Lo visual se puede cambiar por completo, incluido el símbolo del fuego, para que se vea más fachero.
- Antes del rediseño, la versión v65 quedó en el commit `7ad1b1c73a076c3650ea333afe92ac085672e2e5` del repositorio. Si el rediseño no convence, se vuelve a ese diseño desde ahí.

## Evidence on Hand
- Usuarios reales: grupos de amigos, familia y trabajo, con rachas de grupo de hasta 34 días y rachas personales de cientos de días.
- No hay testimonios, métricas públicas ni prensa: no inventarlos.

## Product Principles
1. Anotar tiene que ser más rápido que no anotar: un toque, siempre.
2. La racha es lo más valioso que tiene el usuario: nunca se pierde por un error de la app, y todo se puede deshacer.
3. Los amigos empujan, no castigan: empujones, hielitos regalados y banca que se deja atrás sola.
4. Constancia antes que intensidad: mejor bajar la meta que cortar la racha.
5. Cada pantalla muestra primero lo de hoy.

## Accessibility & Inclusion
Uso a una mano y de noche: modo oscuro de primera, botones grandes y textos legibles. Respetar `prefers-reduced-motion`.
