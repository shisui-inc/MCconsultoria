$ErrorActionPreference = "Stop"

$htmlPath = ".\mc-asesorias.html"
$html = Get-Content -Raw -Path $htmlPath

# Extract CSS
$cssPattern = '(?s)<style>(.*?)</style>'
$cssMatch = [regex]::Match($html, $cssPattern)
if ($cssMatch.Success) {
    New-Item -ItemType Directory -Force -Path ".\css" | Out-Null
    $cssContent = $cssMatch.Groups[1].Value.Trim()
    [System.IO.File]::WriteAllText(".\css\styles.css", $cssContent, [System.Text.Encoding]::UTF8)
}

# Extract JS
$jsPattern = '(?s)<script>(.*?)</script>'
$jsMatch = [regex]::Match($html, $jsPattern)
if ($jsMatch.Success) {
    New-Item -ItemType Directory -Force -Path ".\js" | Out-Null
    $jsContent = $jsMatch.Groups[1].Value.Trim()
    [System.IO.File]::WriteAllText(".\js\main.js", $jsContent, [System.Text.Encoding]::UTF8)
}

# Replace in HTML
$newHtml = $html -replace '(?s)<style>.*?</style>', '<link rel="stylesheet" href="css/styles.css">'
$newHtml = $newHtml -replace '(?s)<script>.*?</script>', '<script src="js/main.js" defer></script>'

[System.IO.File]::WriteAllText(".\index.html", $newHtml, [System.Text.Encoding]::UTF8)
Remove-Item -Path $htmlPath

Write-Output "Refactoring complete."
