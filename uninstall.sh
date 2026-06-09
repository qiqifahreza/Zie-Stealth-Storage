#!/system/bin/sh

MOUNT_DIR="/data/media/0/.local/zie"
LOCAL_DIR="/data/local/box/zie"
SWITCH_FILE="/data/media/0/.local/status.txt"


if grep -q "$MOUNT_DIR" /proc/mounts; then
    su -c "umount -f -l $MOUNT_DIR" 2>/dev/null
fi


rm -f /data/local/scripts/ziebox.sh
rm -f "$SWITCH_FILE"


rmdir "$MOUNT_DIR" 2>/dev/null
