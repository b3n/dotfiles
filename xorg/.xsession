setxkbmap us
xsetroot -solid black

while true; do
    xsetroot -name "$( date +"%F %R" )"
    sleep 60
done &

until dwm; do
    sleep 1
done
