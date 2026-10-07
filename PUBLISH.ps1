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

git add -A
$dirty = git status --porcelain
if ($dirty) {
    git commit -m "Update menu $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
} else {
    Write-Host "No file changes; skipping commit."
}

$hasOrigin = $false
git remote get-url origin 2>$null | Out-Null
if ($LASTEXITCODE -eq 0) { $hasOrigin = $true }

if (-not $hasOrigin) {
    gh repo create $MenuHost_Repo --public --source=. --remote=origin --push --description "WTPSHOP menu (GitHub Pages)"
} elseif ($dirty) {
    git push origin main
} else {
    Write-Host "Already up to date on origin."
}

$prevEap = $ErrorActionPreference
$ErrorActionPreference = "Continue"
gh api "repos/$($MenuHost_GhUser)/$($MenuHost_Repo)/pages" -X PUT `
    -f build_type=legacy -f "source[branch]=main" -f "source[path]=/docs" 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    gh api "repos/$($MenuHost_GhUser)/$($MenuHost_Repo)/pages" -X POST `
        -f build_type=legacy -f "source[branch]=main" -f "source[path]=/docs" 2>$null | Out-Null
}
$ErrorActionPreference = $prevEap

$direct = "https://raw.githubusercontent.com/$($MenuHost_GhUser)/$($MenuHost_Repo)/main/$MenuHost_Folder/$MenuHost_FileName"
$pagesSite = "https://$($MenuHost_GhUser).github.io/$($MenuHost_Repo)/"

$loader = Join-Path $env:USERPROFILE "Downloads\wtpshop-loader.lua"
if (Test-Path (Split-Path $loader -Parent)) {
    $txt = @'
-- WTPSHOP remote loader - inject once locally.
-- Re-run wtpshop-menu-host\PUBLISH.ps1 after menu edits.

local MENU_CDN_URL = "MENU_URL_PLACEHOLDER"

if not MachoIsolatedInject or not MachoGetRequest then
    print("^1[WTPSHOP]^7 MachoIsolatedInject / MachoGetRequest not available.")
    return
end

print("^2[WTPSHOP]^7 Loading menu from CDN...")
MachoIsolatedInject(MachoGetRequest(MENU_CDN_URL))

'@ -replace 'MENU_URL_PLACEHOLDER', $direct
    [System.IO.File]::WriteAllText($loader, ($txt -replace "`r`n", "`n"))
}

Write-Host ""
Write-Host "Verifying raw URL..."
$ok = $false
foreach ($i in 1..8) {
    try {
        $r = Invoke-WebRequest -Uri $direct -Method Head -UseBasicParsing -TimeoutSec 30
        if ($r.StatusCode -eq 200) { $ok = $true; break }
    } catch {}
    Start-Sleep -Seconds 3
}
if ($ok) {
    Write-Host "  OK $direct" -ForegroundColor Green
} else {
    Write-Host "  Not ready yet - wait ~30s and open URL in browser." -ForegroundColor Yellow
    Write-Host "  $direct"
}

Write-Host ""
Write-Host "Pages site (info only): $pagesSite"
Write-Host ""
Write-Host "Macho:" -ForegroundColor Cyan
Write-Host ('MachoIsolatedInject(MachoGetRequest("' + $direct + '"))')
Write-Host ""
Write-Host "Or inject: C:\Users\Administrator\Downloads\wtpshop-loader.lua"
