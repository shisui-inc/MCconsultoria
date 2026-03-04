$ErrorActionPreference = "Stop"

$htmlPath = ".\index.html"
$utf8 = [System.Text.Encoding]::UTF8
$html = [System.IO.File]::ReadAllText($htmlPath, $utf8)

$html = $html.Replace("</head>", "  <link rel='icon' type='image/svg+xml' href='imag/ISOLOGOMILCIADES.svg'>`n</head>")

$logoOld = '<div class="logo-mark">
      <svg viewBox="0 0 42 42" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect x="1" y="1" width="40" height="40" stroke="#C9A84C" stroke-width="1"/>
        <rect x="6" y="6" width="30" height="30" stroke="#C9A84C" stroke-width="0.5" opacity="0.4"/>
        <text x="21" y="28" font-family="Georgia, serif" font-size="18" font-weight="bold" fill="#C9A84C" text-anchor="middle">MC</text>
      </svg>
    </div>'
$logoNew = '<div class="logo-mark">
      <img src="imag/ISOLOGOMILCIADES.svg" alt="MC Asesorías" style="width: 100%; height: 100%; object-fit: contain;">
    </div>'
$html = $html.Replace($logoOld, $logoNew)

$emblemOld = '<div class="emblem-center">
          <span class="emblem-mc">MC</span>
          <div class="emblem-divider"></div>
          <span class="emblem-sub">Asesorías</span>
        </div>'
$emblemNew = '<div class="emblem-center" style="border: none; background: transparent;">
          <img src="imag/ISOLOGOMILCIADES.svg" alt="MC Asesorías" style="width: 180px; height: auto;">
        </div>'
$html = $html.Replace($emblemOld, $emblemNew)

$navOld = '<li><a href="#contacto" class="nav-cta">Consultar Gratis</a></li>'
$navNew = '<li>
      <div class="lang-switcher">
        <button class="lang-btn active" data-lang="es">ES</button>
        <button class="lang-btn" data-lang="pt">PT</button>
        <button class="lang-btn" data-lang="en">EN</button>
      </div>
    </li>
    <li><a href="#contacto" class="nav-cta">Consultar Gratis</a></li>'
$html = $html.Replace($navOld, $navNew)

$jsOld = '<script src="js/main.js" defer></script>'
$jsNew = '<script src="js/i18n.js" defer></script>
<script src="js/main.js" defer></script>'
$html = $html.Replace($jsOld, $jsNew)

[System.IO.File]::WriteAllText($htmlPath, $html, $utf8)

$cssPath = ".\css\styles.css"
$cssAdd = @"

/* Language Switcher */
.lang-switcher {
  display: flex;
  gap: 4px;
  background: rgba(255,255,255,0.05);
  padding: 4px;
  border-radius: 4px;
  border: 1px solid rgba(201,168,76,0.15);
}
.lang-btn {
  background: transparent;
  border: none;
  color: var(--white-dim);
  font-family: 'DM Mono', monospace;
  font-size: 0.65rem;
  padding: 4px 8px;
  border-radius: 2px;
  cursor: pointer;
  transition: all 0.2s;
}
.lang-btn:hover {
  color: var(--white);
  background: rgba(255,255,255,0.1);
}
.lang-btn.active {
  background: var(--gold);
  color: var(--navy);
  font-weight: 600;
}
"@
# Check if already added
$cssContent = [System.IO.File]::ReadAllText($cssPath, $utf8)
if ($cssContent -notmatch "\.lang-switcher") {
    Add-Content -Path $cssPath -Value $cssAdd -Encoding UTF8
}

if (Test-Path ".\mc-asesorias.html") { Remove-Item ".\mc-asesorias.html" }

Write-Output "Changes applied successfully."
