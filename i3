# Font for window titles.
font pango:Fira Code Retina 9

# Move around, just like in vim.
set $left h
set $down j
set $up k
set $right l

# Start a terminal.
# TODO: replace with Alacritty once #1341 is fixed.
bindsym Mod1+Return exec xterm -fa "Fira Code Retina" -fs 10 -e /usr/bin/bash -il

# Kill focused window.
bindsym Mod1+Shift+q kill

# Start the program launcher.
bindsym Mod1+space exec dmenu_run

# Change focus.
bindsym Mod1+$left focus left
bindsym Mod1+$down focus down
bindsym Mod1+$up focus up
bindsym Mod1+$right focus right

# Move focused window.
bindsym Mod1+Shift+$left move left
bindsym Mod1+Shift+$down move down
bindsym Mod1+Shift+$up move up
bindsym Mod1+Shift+$right move right

# Split windows horizontally and vertically.
bindsym Mod1+b split h
bindsym Mod1+v split v

# Enter and exit fullscreen mode for the focused window.
bindsym Mod1+f fullscreen toggle

# Change container layout (stacked, tabbed, toggle split)
bindsym Mod1+s layout stacking
bindsym Mod1+w layout tabbed
bindsym Mod1+e layout toggle split

# Workspaces.
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
bindsym Mod1+1 workspace $ws1
bindsym Mod1+2 workspace $ws2
bindsym Mod1+3 workspace $ws3
bindsym Mod1+4 workspace $ws4
bindsym Mod1+5 workspace $ws5
bindsym Mod1+6 workspace $ws6
bindsym Mod1+7 workspace $ws7
bindsym Mod1+8 workspace $ws8
bindsym Mod1+9 workspace $ws9
bindsym Mod1+0 workspace $ws10

# Move focused window to workspace.
bindsym Mod1+Shift+1 move container to workspace $ws1
bindsym Mod1+Shift+2 move container to workspace $ws2
bindsym Mod1+Shift+3 move container to workspace $ws3
bindsym Mod1+Shift+4 move container to workspace $ws4
bindsym Mod1+Shift+5 move container to workspace $ws5
bindsym Mod1+Shift+6 move container to workspace $ws6
bindsym Mod1+Shift+7 move container to workspace $ws7
bindsym Mod1+Shift+8 move container to workspace $ws8
bindsym Mod1+Shift+9 move container to workspace $ws9
bindsym Mod1+Shift+0 move container to workspace $ws10

# Reload configuration.
bindsym Mod1+Shift+c reload
# Restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym Mod1+Shift+r restart
# Exit i3 (logs you out of your X session).
bindsym Mod1+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# Resize window.
mode "resize" {
	# These bindings trigger as soon as you enter the resize mode, see below.

	# Increase or decrease the window's.
	bindsym $left       resize shrink width 10 px or 10 ppt
	bindsym $down       resize grow height 10 px or 10 ppt
	bindsym $up         resize shrink height 10 px or 10 ppt
	bindsym $right      resize grow width 10 px or 10 ppt

	# Back to normal.
	bindsym Return mode "default"
	bindsym Escape mode "default"
	bindsym Mod1+r mode "default"
}

# Start resize mode, see above.
bindsym Mod1+r mode "resize"

# i3 status bar.
bar {
	status_command i3status

	# Always dock at the bottom of the screen.
	mode dock
	position bottom
	separator_symbol ·

	# Disable mouse scrolling.
	bindsym button4 nop
	bindsym button5 nop

	# Show the available workspaces.
	workspace_buttons yes
	strip_workspace_numbers no

	# Show if we're not in the default mode.
	binding_mode_indicator yes
}
