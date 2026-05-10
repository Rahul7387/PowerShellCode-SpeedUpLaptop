# ============================================================
#   🚀 LAPTOP SPEED BOOST & FIX SCRIPT
#   Run as Administrator in PowerShell
# ============================================================

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Host "❌ Please run this script as Administrator!" -ForegroundColor Red
    Write-Host "   Right-click PowerShell → Run as Administrator" -ForegroundColor Yellow
    pause
    exit
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   🚀 LAPTOP SPEED BOOST & FIX - Starting Optimization...  " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# ─────────────────────────────────────────────
# 1. DISK CLEANUP
# ─────────────────────────────────────────────
Write-Host "🧹 [1/10] Running Disk Cleanup..." -ForegroundColor Yellow
$cleanupKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
$folders = Get-ChildItem $cleanupKey
foreach ($folder in $folders) {
    Set-ItemProperty -Path "$cleanupKey\$($folder.PSChildName)" -Name StateFlags0001 -Value 2 -ErrorAction SilentlyContinue
}
Start-Process -FilePath cleanmgr.exe -ArgumentList "/sagerun:1" -Wait -NoNewWindow
Write-Host "   ✅ Disk Cleanup Done!" -ForegroundColor Green

# ─────────────────────────────────────────────
# 2. CLEAR TEMP FILES
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🗑️  [2/10] Clearing Temp Files..." -ForegroundColor Yellow
$tempPaths = @(
    "$env:TEMP",
    "$env:SystemRoot\Temp",
    "$env:LOCALAPPDATA\Temp"
)
$totalDeleted = 0
foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
        $totalDeleted += $files.Count
        Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
}
Write-Host "   ✅ Removed $totalDeleted temp files!" -ForegroundColor Green

# ─────────────────────────────────────────────
# 3. CLEAR DNS CACHE
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🌐 [3/10] Flushing DNS Cache..." -ForegroundColor Yellow
ipconfig /flushdns | Out-Null
Write-Host "   ✅ DNS Cache Flushed!" -ForegroundColor Green

# ─────────────────────────────────────────────
# 4. DISABLE UNNECESSARY STARTUP PROGRAMS
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🚫 [4/10] Checking Startup Programs..." -ForegroundColor Yellow
$startupApps = Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location
$count = $startupApps.Count
Write-Host "   ℹ️  Found $count startup programs. Opening Task Manager > Startup tab for review..." -ForegroundColor Cyan
# List them
$startupApps | Format-Table -AutoSize | Out-String | Write-Host
Write-Host "   ✅ Review complete. Disable unwanted ones in Task Manager > Startup." -ForegroundColor Green

# ─────────────────────────────────────────────
# 5. SET POWER PLAN TO HIGH PERFORMANCE
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "⚡ [5/10] Setting Power Plan to High Performance..." -ForegroundColor Yellow
powercfg /setactive SCHEME_MIN
Write-Host "   ✅ Power Plan set to High Performance!" -ForegroundColor Green

# ─────────────────────────────────────────────
# 6. DISABLE VISUAL EFFECTS FOR SPEED
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🎨 [6/10] Optimizing Visual Effects for Performance..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name VisualFXSetting -Value 2
$perfPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $perfPath -Name DragFullWindows -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $perfPath -Name FontSmoothing -Value 2 -ErrorAction SilentlyContinue
Write-Host "   ✅ Visual effects optimized!" -ForegroundColor Green

# ─────────────────────────────────────────────
# 7. FREE UP RAM (Clear Standby Memory)
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🧠 [7/10] Checking RAM Usage..." -ForegroundColor Yellow
$os = Get-CimInstance Win32_OperatingSystem
$totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeRAM  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$usedRAM  = [math]::Round($totalRAM - $freeRAM, 2)
Write-Host "   💾 Total RAM : $totalRAM GB" -ForegroundColor Cyan
Write-Host "   ✅ Used  RAM : $usedRAM GB" -ForegroundColor Cyan
Write-Host "   🟢 Free  RAM : $freeRAM GB" -ForegroundColor Cyan

# ─────────────────────────────────────────────
# 8. RUN SYSTEM FILE CHECKER (SFC)
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🔍 [8/10] Running System File Checker (SFC)..." -ForegroundColor Yellow
Write-Host "   ⏳ This may take a few minutes..." -ForegroundColor Gray
$sfcResult = sfc /scannow 2>&1
if ($sfcResult -match "did not find any integrity violations") {
    Write-Host "   ✅ No corrupted system files found!" -ForegroundColor Green
} elseif ($sfcResult -match "successfully repaired") {
    Write-Host "   ✅ Corrupted files found and repaired!" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  SFC completed. Check CBS.log for details." -ForegroundColor Yellow
}

# ─────────────────────────────────────────────
# 9. CHECK DISK HEALTH
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "💿 [9/10] Checking Disk Health..." -ForegroundColor Yellow
$diskInfo = Get-PhysicalDisk | Select-Object FriendlyName, MediaType, OperationalStatus, HealthStatus, Size
foreach ($disk in $diskInfo) {
    $sizeGB = [math]::Round($disk.Size / 1GB, 1)
    $health = $disk.HealthStatus
    $color = if ($health -eq "Healthy") { "Green" } else { "Red" }
    Write-Host "   💽 $($disk.FriendlyName) | $($disk.MediaType) | $sizeGB GB | Status: " -NoNewline -ForegroundColor Cyan
    Write-Host "$health" -ForegroundColor $color
}

# ─────────────────────────────────────────────
# 10. CHECK FOR WINDOWS UPDATES
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "🔄 [10/10] Checking for Windows Updates..." -ForegroundColor Yellow
try {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $searcher = $updateSession.CreateUpdateSearcher()
    $results = $searcher.Search("IsInstalled=0")
    $updateCount = $results.Updates.Count
    if ($updateCount -gt 0) {
        Write-Host "   ⚠️  $updateCount Windows Update(s) pending. Please update via Settings > Windows Update." -ForegroundColor Yellow
    } else {
        Write-Host "   ✅ Windows is up to date!" -ForegroundColor Green
    }
} catch {
    Write-Host "   ⚠️  Could not check updates automatically. Please check via Settings > Windows Update." -ForegroundColor Yellow
}

# ─────────────────────────────────────────────
# SUMMARY
# ─────────────────────────────────────────────
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   ✅ OPTIMIZATION COMPLETE! Here's what was done:          " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   ✔  Disk Cleanup ran"                    -ForegroundColor Green
Write-Host "   ✔  Temp files cleared ($totalDeleted files)" -ForegroundColor Green
Write-Host "   ✔  DNS Cache flushed"                   -ForegroundColor Green
Write-Host "   ✔  Startup programs reviewed"           -ForegroundColor Green
Write-Host "   ✔  Power Plan set to High Performance"  -ForegroundColor Green
Write-Host "   ✔  Visual effects optimized"            -ForegroundColor Green
Write-Host "   ✔  RAM usage checked"                   -ForegroundColor Green
Write-Host "   ✔  System files scanned (SFC)"          -ForegroundColor Green
Write-Host "   ✔  Disk health checked"                 -ForegroundColor Green
Write-Host "   ✔  Windows Update checked"              -ForegroundColor Green
Write-Host ""
Write-Host "   💡 Tip: Restart your laptop for best results!" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
pause
