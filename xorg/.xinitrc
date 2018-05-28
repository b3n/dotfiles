setxkbmap us
setxkbmap -option compose:ralt
xbindkeys

redshift -l 55.94:-3.21 &

xrdb .Xresources

#thunar --daemon &
#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

while true; do
   xsetroot -name "$( date +"%F %R" )"
   sleep 1m
done &

#compton -cf --backend xr_glx_hybrid --vsync opengl --xrender-sync-fence --vsync-aggressive --xrender-sync -m .9 &
exec dwm
