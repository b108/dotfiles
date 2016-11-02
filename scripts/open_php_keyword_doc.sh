#!/bin/sh

ACTIVE_WINDOW_ID=$(xdotool getwindowfocus)

firefox http://ru.php.net/$1

wmctrl -i -a $ACTIVE_WINDOW_ID
