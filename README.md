# 🚀 PowerShell Laptop Speed Boost & Fix Script

A powerful **Windows Laptop Optimization Script** that automatically cleans, tunes, and fixes your system in one click — no technical knowledge required!

---

## 📋 Description

This PowerShell script performs **10 automated optimization tasks** to speed up your Windows laptop and fix common issues. It cleans junk files, boosts performance settings, scans for system errors, and checks hardware health — all in one run.

> ✅ **Safe to use** — Does NOT delete any personal files (Documents, Photos, Videos, Downloads, etc.)

---

## ✨ Features

| # | Task | What it Does |
|---|------|-------------|
| 1 | 🧹 Disk Cleanup | Runs Windows built-in cleaner to remove junk & old update files |
| 2 | 🗑️ Clear Temp Files | Deletes temporary files from system temp folders |
| 3 | 🌐 Flush DNS Cache | Resets internet cache to fix slow or broken browsing |
| 4 | 🚫 Startup Programs | Lists all apps that auto-start at boot for your review |
| 5 | ⚡ High Performance Mode | Switches power plan to maximum performance |
| 6 | 🎨 Visual Effects | Turns off heavy animations to free up CPU & RAM |
| 7 | 🧠 RAM Usage Check | Displays total, used, and free memory |
| 8 | 🔍 SFC Scan | Scans and repairs corrupted Windows system files |
| 9 | 💿 Disk Health Check | Checks if your hard drive or SSD is healthy |
| 10 | 🔄 Windows Update | Checks if any Windows updates are pending |

---

## 🖥️ Requirements

- **OS:** Windows 10 or Windows 11
- **PowerShell:** Version 5.0 or higher (pre-installed on Windows)
- **Privileges:** Must be run as **Administrator**

---

## ▶️ How to Run

### Method 1 — Direct Run (Easiest)
1. Download `SpeedUpLaptop.ps1`
2. **Right-click** the file
3. Select **"Run with PowerShell"**
4. If prompted, click **Yes** on the UAC (Admin) dialog

### Method 2 — Via PowerShell Terminal
1. Open **PowerShell as Administrator**
   - Press `Win + X` → Select **Windows PowerShell (Admin)**
2. Allow script execution (one-time setup):
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```
3. Navigate to the script folder:
   ```powershell
   cd "C:\Path\To\Script"
   ```
4. Run the script:
   ```powershell
   .\SpeedUpLaptop.ps1
   ```

---

## 📸 What to Expect

```
============================================================
   🚀 LAPTOP SPEED BOOST & FIX - Starting Optimization...
============================================================

🧹 [1/10] Running Disk Cleanup...          ✅ Done!
🗑️  [2/10] Clearing Temp Files...          ✅ Removed 320 temp files!
🌐 [3/10] Flushing DNS Cache...            ✅ DNS Cache Flushed!
🚫 [4/10] Checking Startup Programs...     ✅ Review complete.
⚡ [5/10] Setting Power Plan...            ✅ High Performance set!
🎨 [6/10] Optimizing Visual Effects...     ✅ Effects optimized!
🧠 [7/10] Checking RAM Usage...            🟢 Free RAM: 4.2 GB
🔍 [8/10] Running SFC Scan...              ✅ No corrupted files found!
💿 [9/10] Checking Disk Health...          ✅ Healthy
🔄 [10/10] Checking Windows Updates...     ✅ Windows is up to date!

============================================================
   ✅ OPTIMIZATION COMPLETE!
   💡 Tip: Restart your laptop for best results!
============================================================
```

---

## 🔒 Safety & What It Does NOT Touch

- ❌ Your **Documents, Photos, Videos, Music**
- ❌ Your **Desktop files**
- ❌ Your **Downloads folder**
- ❌ Any **installed apps or software**
- ❌ Any **personal or user data**

---

## ⏱️ Estimated Run Time

| Step | Time |
|------|------|
| Disk Cleanup | ~1–2 min |
| SFC Scan | ~2–3 min |
| All other steps | ~30 sec |
| **Total** | **~3–5 minutes** |

---

## 💡 Tips After Running

- **Restart your laptop** after the script completes for best results
- Disable unwanted **Startup Programs** shown in Step 4 via Task Manager
- Install pending **Windows Updates** shown in Step 10

---

## 📁 File Structure

```
PowerShellCode-SpeedUpLaptop/
│
├── SpeedUpLaptop.ps1     # Main optimization script
└── README.md             # Documentation
```

---

## 👤 Author

**Rahul Gupta**
GitHub: [@Rahul7387](https://github.com/Rahul7387)

---

## 📄 License

This project is open source and free to use.
