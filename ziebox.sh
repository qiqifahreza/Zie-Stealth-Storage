#!/system/bin/sh
LOCAL_DIR="/path/to/files/zie"
MOUNT_DIR="/data/media/0/.local/zie"
SWITCH_FILE="/data/media/0/.local/status.txt"

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
    
    echo "======================================"
    echo "Zie-Stealth-Storage is Locked!"
    echo "======================================"
else
    # Open instantly if cleared in kernel mount
    mount --bind "$LOCAL_DIR" "$MOUNT_DIR"
    chown -R media_rw:media_rw "$MOUNT_DIR"
    chmod -R 2770 "$MOUNT_DIR"
    
    # Update status ON
    echo "ON" > "$SWITCH_FILE"
    chown media_rw:media_rw "$SWITCH_FILE" 2>/dev/null
    chmod 660 "$SWITCH_FILE" 2>/dev/null
    
    echo "======================================"
    echo "Zie-Stealth-Storage is Opened!"
    echo "======================================"
fi