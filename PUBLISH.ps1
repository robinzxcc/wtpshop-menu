# GitHub Pages menu host — no Cloudflare, no card.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
. "$PSScriptRoot\publish-config.ps1"

if (-not (Test-Path $MenuHost_SourceMenu)) {
    Write-Error "Menu not found: $MenuHost_SourceMenu"
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing GitHub CLI..."
    winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
        [System.Environment]::GetEnvironmentVariable("Path", "User")
}

gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Log in to GitHub (browser) as $($MenuHost_GhUser):"
    gh auth login -h github.com -p https -w
}

$destDir = Join-Path $PSScriptRoot $MenuHost_Folder
New-Item -ItemType Directory -Force -Path $destDir | Out-Null
Copy-Item -Path $MenuHost_SourceMenu -Destination (Join-Path $destDir $MenuHost_FileName) -Force

if (-not (Test-Path ".git")) {
    git init
    git branch -M main
    git config user.email "41898282+robinzxcc@users.noreply.github.com"
    git config user.name "robinzxcc"
}

git add .
git commit -m "Update menu" 2>$null
if ($LASTEXITCODE -ne 0) {
    git commit -m "Update menu" --allow-empty
}

$remote = "https://github.com/$($MenuHost_GhUser)/$($MenuHost_Repo).git"
if (-not (git remote get-url origin 2>$null)) {
    gh repo create $MenuHost_Repo --public --source=. --remote=origin --push --description "WTPSHOP menu (GitHub Pages)"
} else {
    git push -u origin main
}

gh api "repos/$($MenuHost_GhUser)/$($MenuHost_Repo)/pages" -X POST `
    -f build_type=legacy -f "source[branch]=main" -f "source[path]=/" 2>$null
if ($LASTEXITCODE -ne 0) {
    gh api "repos/$($MenuHost_GhUser)/$($MenuHost_Repo)/pages" -X PUT `
        -f build_type=legacy -f "source[branch]=main" -f "source[path]=/" 2>$null
}

$base = "https://$($MenuHost_GhUser).github.io/$($MenuHost_Repo)"
$direct = "$base/$MenuHost_Folder/$MenuHost_FileName"

$loader = "C:\Users\Administrator\Downloads\wtpshop-loader.lua"
if (Test-Path $loader) {
    $txt = Get-Content $loader -Raw
    $txt = $txt -replace 'local MENU_CDN_URL = "[^"]*"', "local MENU_CDN_URL = `"$direct`""
    Set-Content -Path $loader -Value $txt -Encoding UTF8
}

Write-Host ""
Write-Host "Menu URL (wait 1-3 min after first publish):" -ForegroundColor Green
Write-Host "  $direct"
Write-Host ""
Write-Host "Macho:" -ForegroundColor Cyan
Write-Host ('MachoIsolatedInject(MachoGetRequest("' + $direct + '"))')
Write-Host ""
Write-Host "Or inject: C:\Users\Administrator\Downloads\wtpshop-loader.lua"
