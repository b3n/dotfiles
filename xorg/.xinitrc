setxkbmap us
setxkbmap -option compose:ralt

redshift -l 55.94:-3.21 &
xrdb .Xresources

thunar --daemon &
#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

#exec emacs --debug-init
exec emacsclient -a "" -c
