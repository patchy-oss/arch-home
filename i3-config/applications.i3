# Start applications
# As an example
# bindsym $mod+F1 exec i3-sensible-terminal -t browser-www -e firefox

# Start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id dmenu_run

# Start terminal
bindsym $mod+Return exec i3-sensible-terminal

# Toggle VPN
bindsym $mod+Shift+v exec i3-sensible-terminal -t term-popup -e wg-toggle

# Print screen
bindsym --release $mod+Print exec scrot

# Print screen (area to clipboard)
bindsym --release $mod+Shift+Print exec scrotclip

# The combination of xss-lock, nm-applet and pactl is a popular choice, so
# they are included here as an example. Modify as you see fit.
# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

# Use pactl to adjust volume
bindsym $mod+slash exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%
bindsym $mod+period exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%
bindsym $mod+m exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym $mod+Shift+m exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Autostart
exec --no-startup-id feh --bg-fill --randomize ~/backgrounds
# exec --no-startup-id fcitx5 -d
exec --no-startup-id ibus-daemon -drxR

# Assigns
assign [class="Steam"] $ws8

# For_window
for_window [title="term-popup"] floating enable

