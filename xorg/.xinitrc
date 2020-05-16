xrandr --output DP1 --auto --output HDMI2 --auto --right-of DP1
redshift -l 55.94:-3.21 -t 6500K:3500K &

setxkbmap -option compose:ralt
xbindkeys

ibus-daemon -drx
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export VISUAL=emacsclient
export EDITOR="$VISUAL"

pulseaudio -D
thunar --daemon &

compton -cf --backend xr_glx_hybrid --vsync opengl --xrender-sync-fence --vsync-aggressive --xrender-sync -m .9 &
exec emacs -f exwm-enable
