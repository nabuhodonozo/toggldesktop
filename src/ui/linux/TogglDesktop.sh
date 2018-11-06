#!/bin/bash
appname=`basename "$(test -L "$0" && readlink "$0" || echo "$0")" | sed s,\.sh$,,`
dirname=`dirname "$(test -L "$0" && readlink "$0" || echo "$0")"`
tmp="${dirname#?}"

if [ "${dirname%$tmp}" != "/" ]; then
dirname=$PWD/$dirname
fi

LD_LIBRARY_PATH=$dirname/lib
export LD_LIBRARY_PATH

QTWEBENGINEPROCESS_PATH=$dirname/lib/QtWebEngineProcess
export QTWEBENGINEPROCESS_PATH

# Xubuntu, i3 and Cinnamon tray icon fix
XDG=$XDG_CURRENT_DESKTOP

if [[ "$XDG" = "X-Cinnamon" || "$XDG" = "XFCE" || "$XDG" = "Pantheon" || "$XDG" = "i3" || "$XDG" = "LXDE" || "$XDG" = "MATE" || "$XDG" = "Budgie:GNOME" || "$XDG" = "GNOME" ]]; then
  QT_QPA_PLATFORMTHEME=gtk3
  DBUS_SESSION_BUS_ADDRESS=""
  dbus-launch $dirname/$appname "$@" &
else
  $dirname/$appname "$@" &
fi;
