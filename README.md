# 🔒 Zie Stealth Storage v4.0

Complete documentation for creating, configuring, and automating an Isolated Stealth Storage on Modern Android using On-Demand Script. This solution is secure, very lightweight, and free from kernel panic/freeze issues.

---

## 🛠️ 1. Initial File & Directory Preparation

Before running the main script, ensure the parent directory and the flag switch file have been created. This step must be executed directly from the root terminal (`su`):

```bash
# Create an isolated physical directory in the pure root zone
mkdir -p /path/to/files/zie

# Set strict access rights for security
chown -R media_rw:media_rw /path/to/files/zie
chmod -R 2770 /path/to/files/zie

# Create a gateway directory (mountpoint) on internal storage
mkdir -p /data/media/0/.local/zie

# Creates an initial status marker file (default: OFF)
echo "OFF" > /data/media/0/.local/status.txt
chown media_rw:media_rw /data/media/0/.local/status.txt
chmod 660 /data/media/0/.local/status.txt
```

## 📜 2. Main Script Setup (ziebox.sh)

This script intelligently looks directly at the kernel's /proc/mounts table to accurately detect mount status. This has proven effective in preventing duplicate bind mounts.

⚠️ IMPORTANT: If you are customizing the paths, make sure to change the LOCAL_DIR value inside the script to match your actual vault location (/path/to/files/zie), and save the script file as /path/to/scripts/ziebox.sh.

scripts is here: [ziebox.sh](https://github.com/qiqifahreza/Zie-Stealth-Storage/blob/main/ziebox.sh)

### Granting execution permission

```bash
chmod +x /path/to/scripts/ziebox.sh
```

## 🚀 3. Alias ​​Configuration Options (Optional)

### A. for MKSH / Android Default (.mkshrc)

If accessing directly from a local Android terminal, open the shell configuration file (e.g. /system/etc/.mkshrc) and add this line at the very bottom:

```bash
alias zie="sh /path/to/scripts/ziebox.sh"
```

### B. For Termux (User Area)

If you prefer to control your vault via Termux without wanting to manually enter the su shell first, paste this line into Termux's ~/.bashrc or ~/.zshrc file:

```bash
alias zieswitch="su -c '/path/to/scripts/ziebox.sh'"
alias ziestats="su -c 'cat /sdcard/.local/status.txt'"
```

- **`zieswitch`** : Effortlessly toggle your stealth vault with just a single word command.
- **`ziestats`** : Instantly peek at the actual vault status (`ON` / `OFF`) directly on your terminal screen.

## 💎 Advantages of this method:

1. Light & No Delay: The script is only active for a moment when triggered, otherwise it consumes 0% of RAM or daily battery resources.
2. Crash Free: Avoids deadlocks in the Android storage daemon (vold) which often causes the phone to suddenly freeze and then reboot itself.
3. Perfect Gray: Pure ownership sync to media_rw makes the application smoothly read the directory without Permission Denied issues.
