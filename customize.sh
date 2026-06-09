#!/system/bin/sh

# Teks sambutan saat instalasi di Manager Root
ui_print "- Preparing Zie Stealth Storage folders..."

# 1. Buat direktori tujuan di sistem lokal jika belum ada
mkdir -p /data/local/scripts
mkdir -p /data/local/box/zie

# 2. Ekstrak/Pindahkan ziebox.sh dari dalam ZIP modul ke folder tujuan
ui_print "- Deploying ziebox.sh to /data/local/scripts/..."
cp "$MODPATH/ziebox.sh" /data/local/scripts/ziebox.sh

# 3. Berikan izin akses eksekusi ketat (rwxr-xr-x)
chmod +x /data/local/scripts/ziebox.sh

ui_print "- Setting up action.sh executable permission..."
# Berikan izin eksekusi juga untuk tombol action.sh bawaan modul
chmod 755 "$MODPATH/action.sh"

ui_print "- Installation finished successfully, bro Zie! 😎"

/data/local/scripts/ziebox.sh