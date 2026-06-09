#!/system/bin/sh
LOCAL_DIR="/data/local/box/zie"
MOUNT_DIR="/data/media/0/.local/zie"
SWITCH_FILE="/data/media/0/.local/status.txt"
PROP_FILE="/data/adb/modules/zie_stealth_storage/module.prop"

# Verify directories are ready
mkdir -p "$LOCAL_DIR"
mkdir -p "$MOUNT_DIR"

# Check active mounts in kernel
if grep -q "$MOUNT_DIR" /proc/mounts; then
    # close instantly if already in kernel mount
    umount -f -l "$MOUNT_DIR" 2>/dev/null
    
    # Update status OFF
    echo "OFF" > "$SWITCH_FILE"
    chown media_rw:media_rw "$SWITCH_FILE" 2>/dev/null
    chmod 660 "$SWITCH_FILE" 2>/dev/null

    if [ -f "$PROP_FILE" ]; then
        sed -i 's/description=.*/description=Isolated Stealth Storage on Modern Android. [STATUS: 🔒 LOCKED]/' "$PROP_FILE"
    fi
    
    echo "======================================"
    echo "Zie-Stealth-Storage is Locked!"
    echo "======================================"
else
    # Open instantly if cleared in kernel mount
    mount --bind "$LOCAL_DIR" "$MOUNT_DIR"
    
    mount -o remount,"$MOUNT_DIR" 2>/dev/null
    
    # Set user access
    chown -R media_rw:media_rw "$MOUNT_DIR"
    chmod -R 2770 "$MOUNT_DIR"
    
    # Update status ON
    echo "ON" > "$SWITCH_FILE"
    chown media_rw:media_rw "$SWITCH_FILE" 2>/dev/null
    chmod 660 "$SWITCH_FILE" 2>/dev/null

    if [ -f "$PROP_FILE" ]; then
        sed -i 's/description=.*/description=Isolated Stealth Storage on Modern Android. [STATUS: 🔓 OPENED]/' "$PROP_FILE"
    fi
    
    echo "======================================"
    echo "Zie-Stealth-Storage is Opened!"
    echo "======================================"
fi
