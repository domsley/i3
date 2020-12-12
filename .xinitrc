#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# Display resolution 
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --rate 144 --pos 1920x149 --rotate right --output DP-0 --rate 239 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off &

# Mouse sensitivity
xinput set-prop 11 298 -1 &

# Compositor
picom -f &

# Wallpaper
nitrogen --restore &

# Hide pointer when typing
xbanish &

# Only if you use DWM
# while true; do
# 	dwm >/dev/null 2>&1
# done

exec i3
