# shut down, locking, etc.
bindsym $mod+0 mode "$mode_system"
set $mode_system (l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown
mode "$mode_system" {
	bindsym l exec --no-startup-id i3exit lock, mode "default"
	bindsym s exec --no-startup-id i3exit suspend, mode "default"
	bindsym u exec --no-startup-id i3exit switch_user, mode "default"
	bindsym e exec --no-startup-id i3exit logout, mode "default"
	bindsym h exec --no-startup-id i3exit hibernate, mode "default"
	bindsym r exec --no-startup-id i3exit reboot, mode "default"
	bindsym Shift+s exec --no-startup-id i3exit shutdown, mode "default"

	bindsym Return mode "default"
	bindsym Escape mode "default"
}

