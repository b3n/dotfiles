setxkbmap us
setxkbmap -option compose:ralt
usbhidaction  -c ~/.usbhid.conf -f /dev/uhid1

xsetroot -solid black

while true; do
    xsetroot -name "$( date +"%F %R" )"
    sleep 60
done &

until dwm; do
    sleep 1
done
