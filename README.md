# 🔒 Zie Stealth Storage v4.0

An elegant, robust, and highly automated solution for creating an On-Demand Isolated Stealth Storage on Modern Android. Fully integrated as a flashable Magisk/KernelSU/APatch module featuring an interactive Manager Root UI switch.

This project bypasses the Android storage daemon (`vold`) constraints, successfully preventing duplicate mounts, memory deadlocks, and kernel freeze issues while maintaining strict file permission ownership.

---

## 💎 Features & Advantages

* **Zero Background Process**: The script is execution-triggered only, consuming 0% RAM and battery resources in standby.
* **No Kernel Panic**: Clean bind mounts directly visible across namespaces without hanging up the system UI.
* **Dynamic Module UI**: The description status inside your Magisk/KernelSU Manager changes dynamically `[STATUS: 🔓 OPENED]` or `[STATUS: 🔒 LOCKED]` in real-time.
* **Scoped Storage Bypass**: Seamless access inside modern Android File Managers (like ZArchiver) via synchronized FUSE forced-remounts.

---

## 📂 Module Directory Structure

When packaged as a flashable zip file, the structure inside is as follows:
```text
Zie_Stealth_Storage.zip
├── module.prop      # Core module identification & live description
├── customize.sh     # Installation script (deploys ziebox to /data/local)
├── action.sh        # Physical action button bridge for Manager Root
├── uninstall.sh     # Clean-up script upon module removal
└── ziebox.sh        # The monolithic script handling all core mount & UI logic
```

## 🛠️ Installation & Setup

1. Compress all the module files into a single .zip archive.
2. Flash the zip file via Magisk, KernelSU, or APatch manager.
3. Reboot your device to let the system initialize the basic paths.

[ !NOTE ]
The installation process via customize.sh will automatically deploy the core binary to /data/local/scripts/ziebox.sh and create the core vault directory structure at /data/local/box/zie automatically.

## 🚀 How To Use

You have two powerful methods to control and toggle your isolated stealth vault:

### Method A: Interactive UI Button (Recommended)

1. Open your Magisk / KernelSU / APatch app.
2. Go to the Modules tab and locate Zie Stealth Storage.
3. Tap the "Action" or "WebUI" button.
4. The terminal output will instantly prompt the status, and the module description will reflect the state with dynamic emojis (🔒 LOCKED / 🔓 OPENED).

### Method B: Terminal Aliases (Optional Automation) For Termux Users (User Area)

If you prefer triggering your safe storage via Termux without diving into a manual root shell every time, append these configurations to your Termux configuration file (~/.bashrc or ~/.zshrc):

```bash
alias zieswitch="su -c '/data/local/scripts/ziebox.sh'"
alias ziestats="su -c 'cat /sdcard/.local/status.txt'"
```

* Execute zieswitch to smoothly toggle your stealth vault back and forth using just one single command word.
* Execute ziestats to cleanly print out the current flag state (ON / OFF) directly onto your terminal emulator viewport.

### For Default Android Shell (.mkshrc)

If you access the shell via local adb or integrated terminal setups, you can bind it natively to the system terminal by adding this line at the bottom of /system/etc/.mkshrc:

```bash
alias zie="sh /data/local/scripts/ziebox.sh"
```

## ⚠️ Important Security Notes

[ !WARNING ]
By default, the uninstall.sh script does NOT remove your physical storage at /data/local/box/zie to prevent unintended data loss when updating or re-installing the module. If you wish to wipe everything out completely when uninstalled, uncomment the deletion code inside the module's uninstall.sh manually.

### 👨‍💻 Author & Credits

* **Developer**: [@qiqifahreza](https://github.com/qiqifahreza)
* **Project Page**: [Zie Stealth Storage Repository](https://github.com/qiqifahreza/Zie-Stealth-Storage.git)
