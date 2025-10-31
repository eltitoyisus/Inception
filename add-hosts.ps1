# Add domain to hosts file
$hostsPath = "C:\Windows\System32\drivers\etc\hosts"
$domain = "127.0.0.1 jramos-a.42.fr"

# Check if running as administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator', then run this script again." -ForegroundColor Yellow
    exit 1
}

# Check if entry already exists
$hostsContent = Get-Content $hostsPath -Raw
if ($hostsContent -match "jramos-a.42.fr") {
    Write-Host "jramos-a.42.fr already exists in hosts file!" -ForegroundColor Yellow
} else {
    # Add the domain to hosts file
    Add-Content -Path $hostsPath -Value $domain
    Write-Host "Successfully added jramos-a.42.fr to hosts file!" -ForegroundColor Green
}

Write-Host ""
Write-Host "You can now access your site at: https://jramos-a.42.fr" -ForegroundColor Cyan
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
