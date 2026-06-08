#!/system/bin/sh
LOCAL_DIR="/data/local/home/zie"
MOUNT_DIR="/data/media/0/.local/zie"
SWITCH_FILE="/data/media/0/.local/status.txt"

# Pastikan folder fisik & gerbangnya siap
mkdir -p "$LOCAL_DIR"
mkdir -p "$MOUNT_DIR"

# 🔍 Intip langsung ke tabel kernel /proc/mounts
if grep -q "$MOUNT_DIR" /proc/mounts; then
    # JIKA TERDETEKSI DI KERNEL -> TUTUP INSTAN
    umount -f -l "$MOUNT_DIR" 2>/dev/null
    
    # 📝 Update status file menjadi OFF
    echo "OFF" > "$SWITCH_FILE"
    chown media_rw:media_rw "$SWITCH_FILE" 2>/dev/null
    chmod 660 "$SWITCH_FILE" 2>/dev/null
    
    echo "======================================"
    echo "🔒 BRANKAS ZIE BERHASIL DIKUNCI!"
    echo "======================================"
else
    # JIKA BERSIH DI KERNEL -> BUKA INSTAN
    mount --bind "$LOCAL_DIR" "$MOUNT_DIR"
    chown -R media_rw:media_rw "$MOUNT_DIR"
    chmod -R 2770 "$MOUNT_DIR"
    
    # 📝 Update status file menjadi ON
    echo "ON" > "$SWITCH_FILE"
    chown media_rw:media_rw "$SWITCH_FILE" 2>/dev/null
    chmod 660 "$SWITCH_FILE" 2>/dev/null
    
    echo "======================================"
    echo "🔓 BRANKAS ZIE TERBUKA & ABU-ABU!"
    echo "======================================"
fi