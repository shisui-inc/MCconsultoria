$ErrorActionPreference = "Stop"

$files = @(
    ".\index.html",
    ".\css\styles.css",
    ".\js\main.js"
)

$isoEncoding = [System.Text.Encoding]::GetEncoding("Windows-1252")
$utf8Encoding = [System.Text.Encoding]::UTF8

foreach ($file in $files) {
    if (Test-Path $file) {
        try {
            # Read the corrupted string as UTF-8
            $text = [System.IO.File]::ReadAllText($file, $utf8Encoding)
            
            # Recast the chars to bytes using Windows-1252
            $originalBytes = $isoEncoding.GetBytes($text)
            
            # Decode the original bytes as UTF-8
            $fixedText = $utf8Encoding.GetString($originalBytes)
            
            # Write back as UTF-8
            [System.IO.File]::WriteAllText($file, $fixedText, $utf8Encoding)
            Write-Output "Fixed $file"
        } catch {
            Write-Output "Error fixing $file : $_"
        }
    }
}
