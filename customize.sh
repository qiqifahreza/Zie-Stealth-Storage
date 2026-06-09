#!/system/bin/sh


ui_print "- Preparing Zie Stealth Storage folders..."


mkdir -p /data/local/scripts
mkdir -p /data/local/box/zie


ui_print "- Deploying ziebox.sh to /data/local/scripts/..."
cp "$MODPATH/ziebox.sh" /data/local/scripts/ziebox.sh


chmod +x /data/local/scripts/ziebox.sh

ui_print "- Setting up action.sh executable permission..."

chmod 755 "$MODPATH/action.sh"

ui_print "- Installation finished successfully, bro Zie! 😎"

/data/local/scripts/ziebox.sh