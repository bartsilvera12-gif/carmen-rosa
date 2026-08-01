# Carmen Rosa - build para produccion.
# Genera la carpeta dist/ lista para subir a Hostinger (public_html).
#
#   powershell -ExecutionPolicy Bypass -File build.ps1
#
# El sitio es estatico: el "build" copia los archivos publicables y agrega
# el .htaccess de deploy/ (compresion, cache y HTTPS).
#
# Nota: este archivo se mantiene solo en ASCII. PowerShell 5.1 lee los .ps1
# sin BOM como ANSI y algunos acentos rompen el parser.

$ErrorActionPreference = 'Stop'
$raiz = $PSScriptRoot
$dist = Join-Path $raiz 'dist'

# 1. Limpiar
if (Test-Path $dist) { Remove-Item $dist -Recurse -Force }
New-Item -ItemType Directory -Path $dist | Out-Null

# 2. Copiar lo publicable (quedan fuera design-source/, deploy/, README.md y este script)
Copy-Item (Join-Path $raiz 'index.html') $dist
Copy-Item (Join-Path $raiz 'robots.txt') $dist
Copy-Item (Join-Path $raiz 'assets') $dist -Recurse
Copy-Item (Join-Path $raiz 'deploy\.htaccess') $dist

# 3. Versionar CSS y JS (cache busting).
# El .htaccess cachea estos archivos un anio: sin el ?v= el navegador y el
# servidor siguen entregando la version vieja despues de cada despliegue.
$indice = Join-Path $dist 'index.html'
$html = [System.IO.File]::ReadAllText($indice, [System.Text.Encoding]::UTF8)
foreach ($archivo in @('styles.css', 'video.js')) {
  $ruta = Join-Path $dist "assets\$archivo"
  $hash = (Get-FileHash $ruta -Algorithm MD5).Hash.Substring(0, 8).ToLower()
  $html = $html.Replace("assets/$archivo", "assets/$archivo`?v=$hash")
  Write-Output "  $archivo -> ?v=$hash"
}
[System.IO.File]::WriteAllText($indice, $html, (New-Object System.Text.UTF8Encoding($false)))

# 4. Resumen
$archivos = Get-ChildItem $dist -Recurse -File -Force
$peso = [math]::Round(($archivos | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Output "Build listo en dist/ - $($archivos.Count) archivos, $peso MB"
Write-Output "Subir el CONTENIDO de dist/ a public_html en Hostinger."
