# Carmen Rosa — Música y Ministerio

Sitio web oficial de Carmen Rosa. Sitio estático (HTML + CSS + un poco de JS), sin build,
sin dependencias y sin framework: se despliega tal cual en cualquier hosting.

## Estructura

```
index.html              La página completa
assets/styles.css       Estilos base y componentes (botones, tarjeta de video)
assets/video.js         Reproductor liviano de YouTube (carga el iframe recién al hacer clic)
assets/img/             Imágenes optimizadas
design-source/          Export original de Claude Design (.dc.html) — solo referencia
robots.txt
```

`design-source/` no forma parte del sitio publicado; queda versionado para poder volver
a abrir el diseño original en Claude Design si hace falta rehacer una sección.

## Ver en local

Cualquier servidor estático sirve. Con Python:

```bash
python -m http.server 5173
```

Después abrir http://localhost:5173

## Desplegar

El sitio es la raíz del repo, sin comando de build.

- **Vercel**: importar el repo → Framework preset `Other`, Build command vacío, Output directory `.`
- **Netlify**: importar el repo → Build command vacío, Publish directory `.`
- **GitHub Pages**: Settings → Pages → Deploy from branch → `main` / `/ (root)`
- **Cualquier hosting/cPanel**: subir por FTP el contenido del repo a `public_html`

## Pendientes antes de publicar

1. **Dominio**: reemplazar `https://TU-DOMINIO.com` en `index.html` (canonical, Open Graph
   y JSON-LD) por el dominio real. Son 6 apariciones.
2. **Redes sociales**: en la sección *Presencia Digital*, los enlaces de Instagram, Facebook
   y Spotify apuntan a `#digital` (marcador de posición del diseño original). Falta poner
   las URLs reales. Lo mismo con "Ver videos oficiales" (canal de YouTube).
3. **Contacto**: el botón "Contactar al equipo" apunta a `#contacto`. Conviene cambiarlo por
   un `mailto:` real o un formulario.
4. **Press Kit**: "Descargar Press Kit" todavía no enlaza a ningún archivo.
5. **Galería**: el diseño original tenía una sección de galería desactivada por defecto, con
   dos espacios vacíos a la espera de fotos oficiales. No se incluyó en esta versión; se puede
   sumar cuando estén las fotografías.

## Notas técnicas

- Las imágenes originales (3000×3000, 1,7 MB) se redimensionaron a 1400 px y se recomprimieron:
  el sitio completo pesa ahora unos 430 KB de imágenes en lugar de 2 MB.
- Los videos de YouTube usan `youtube-nocookie.com` y solo cargan el reproductor al hacer clic,
  así la primera carga es liviana y no hay cookies de terceros hasta que el usuario reproduce.
- Las tipografías vienen de Google Fonts. Si se quiere evitar la dependencia externa, se pueden
  descargar a `assets/fonts/` y servirlas desde el propio dominio.
