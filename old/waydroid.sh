# DO: /etc/gdm...

# https://docs.waydro.id/usage/install-on-desktops
# https://www.howtogeek.com/waydroid-android-apps-on-linux/

sudo apt install curl ca-certificates -y
curl -s https://repo.waydro.id | sudo bash
sudo apt install waydroid -y
# open waydroid from application menu
# select GAPPS
waydroid prop set persist.waydroid.multi_windows true
sudo waydroid shell
ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = 'android_id';"
waydroid session stop
# wait a
waydroid session start

# and "waydroid session start" to start up

sudo apt install -y gufw
sudo ufw allow 67
sudo ufw allow 53
sudo ufw default allow FORWARD
sudo ufw status verbose

# waydroid app install F-Droid.apk

# remove waydroid
waydroid session stop
sudo waydroid container stop
sudo apt purge -y waydroid && sudo apt autoremove -y
sudo rm -rf /var/lib/waydroid /home/.waydroid ~/waydroid ~/.share/waydroid ~/.local/share/applications/*aydroid* ~/.local/share/waydroid

# waydroid upgrade ??


