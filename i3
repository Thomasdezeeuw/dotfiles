#
## Key bindings.
#

# Use alt as modifier key.
set $mod Mod1

# Move around, just like in vim.
set $left h
set $down j
set $up k
set $right l

# Start a terminal.
# TODO: replace with Alacritty once #1341 is fixed.
bindsym $mod+Return exec xterm -fa "Fira Code Retina" -fs 10 -e /usr/bin/bash -il

# Kill focused window.
bindsym $mod+Shift+q kill

# Start the program launcher.
bindsym $mod+space exec dmenu_run

# Change focus.
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right

# Move focused window.
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right

# Split windows horizontally and vertically.
bindsym $mod+b split h
bindsym $mod+v split v

# Enter and exit fullscreen mode for the focused window.
bindsym $mod+f fullscreen toggle

# Change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

#
# Workspaces.
#

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# Switch to workspace.
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# Move focused window to workspace.
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10

# Reload configuration.
bindsym $mod+Shift+c reload
# Restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# Exit i3 (logs you out of your X session).
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

#
# Resizing windows.
#

mode "resize" {
	# These bindings trigger as soon as you enter the resize mode, see below.

	# Increase or decrease the window's.
	bindsym $left       resize shrink width 5 px or 5 ppt
	bindsym $down       resize grow height 5 px or 5 ppt
	bindsym $up         resize shrink height 5 px or 5 ppt
	bindsym $right      resize grow width 5 px or 5 ppt

	# Back to normal.
	bindsym Return mode "default"
	bindsym Escape mode "default"
	bindsym $mod+r mode "default"
}

# Start resize mode, see above.
bindsym $mod+r mode "resize"

#
# Status bar.
#

bar {
	status_command exec i3status

	# Always dock at the bottom of the screen.
	mode dock
	position top
	separator_symbol " "

	# Disable mouse scrolling.
	bindsym button4 nop
	bindsym button5 nop

	# Show the available workspaces.
	workspace_buttons yes
	strip_workspace_numbers no

	# Show if we're not in the default mode.
	binding_mode_indicator yes

	# Font to use in the status bar.
	font pango:Noto Sans Display, Font Awesome 900 Expanded 10

	colors {
		background #2e3440
		statusline #f8f8f7
		separator  #d1d2d4

		#                 border  background text
		focused_workspace #333434 #595B5B #c6c8c8
		active_workspace  #333434 #626465 #c6c8c8

		#                 border  background text
		binding_mode      #333434 #dc3545 #ffffff
	}
}

#
## Mouse handling.
#

# Focus to the window under the mouse
focus_follows_mouse yes
# Don't wrap the mouse to a window on another monitor.
mouse_warping none

#
## Styling.
#

# Some spacing between windows.
gaps inner 10
gaps outer 10

# Font for window titles.
font pango:Noto Sans Display 900 Expanded 10

# Window title bar and no border.
# TODO: change this to `normal 0`, currently this create a black bakground from
# the to of the screen down the titlebar.
default_border          none
default_floating_border normal 0

# Don't create a double border.
hide_edge_borders both

# Colours for focused window.
set $focused_bg        #2e3440
set $focused_fg        #eff0eb
set $focused_border    #222222
set $focused_indicator #222222

# Colours for unfocused windows.
set $unfocused_bg        #222222
set $unfocused_fg        #eff0eb
set $unfocused_border    #222222
set $unfocused_indicator #222222

client.focused          $focused_border $focused_bg $focused_fg $focused_indicator $focused_border
client.focused_inactive $unfocused_border $unfocused_bg $unfocused_fg $unfocused_indicator $unfocused_border
client.unfocused        $unfocused_border $unfocused_bg $unfocused_fg $unfocused_indicator $unfocused_border
client.urgent           $focused_border $focused_bg $focused_fg $focused_indicator $focused_border
client.placeholder      $focused_border $focused_bg $focused_fg

client.background #ff69b4

# Set the background image.
exec_always --no-startup-id feh --bg-scale $HOME/Documents/bg/current.png
