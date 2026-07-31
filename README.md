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

## Build

Para generar la carpeta publicable:

```bash
powershell -ExecutionPolicy Bypass -File build.ps1
```

Deja en `dist/` el `index.html`, `assets/`, `robots.txt` y el `.htaccess` de `deploy/`
(compresión, caché y redirección a HTTPS). `dist/` no se versiona.

## Desplegar

### Hostinger

1. Ejecutar el build.
2. hPanel → **Administrador de archivos** → entrar a `public_html`.
3. Borrar lo que haya adentro (por defecto trae un `default.php`).
4. Subir el **contenido** de `dist/` (no la carpeta `dist` en sí). Si se sube un `.zip`,
   descomprimirlo ahí mismo y verificar que `index.html` quede en la raíz de `public_html`.
5. Comprobar que el `.htaccess` se subió: en el administrador de archivos hay que activar
   "mostrar archivos ocultos" para verlo.

### Otros

El sitio también es la raíz del repo, sin comando de build.

- **Vercel**: importar el repo → Framework preset `Other`, Build command vacío, Output directory `.`
- **Netlify**: importar el repo → Build command vacío, Publish directory `.`
- **GitHub Pages**: Settings → Pages → Deploy from branch → `main` / `/ (root)`
- **Cualquier hosting/cPanel**: subir por FTP el contenido del repo a `public_html`

## Pendientes antes de publicar

1. **Dominio**: reemplazar `https://TU-DOMINIO.com` en `index.html` (canonical, Open Graph
   y JSON-LD) por el dominio real. Son 6 apariciones.
2. **Galería**: el diseño original tenía una sección de galería desactivada por defecto, con
   dos espacios vacíos a la espera de fotos oficiales. No se incluyó en esta versión; se puede
   sumar cuando estén las fotografías.

## Notas técnicas

- Las imágenes originales (3000×3000, 1,7 MB) se redimensionaron a 1400 px y se recomprimieron:
  el sitio completo pesa ahora unos 430 KB de imágenes en lugar de 2 MB.
- Los videos de YouTube usan `youtube-nocookie.com` y solo cargan el reproductor al hacer clic,
  así la primera carga es liviana y no hay cookies de terceros hasta que el usuario reproduce.
- Las tipografías vienen de Google Fonts. Si se quiere evitar la dependencia externa, se pueden
  descargar a `assets/fonts/` y servirlas desde el propio dominio.
