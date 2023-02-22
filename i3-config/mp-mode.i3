bindsym $mod+p mode "$mode_player"
set $music_folder ~
set $mode_player (p)lay, pa(u)se, (a)dd, playlis(t), (n)ext, p(r)ev, (l)oop, (k)ill
mode "$mode_player" {
    bindsym p exec --no-startup-id 
    bindsym u exec --no-startup-id mpv-mp pause, mode "default"
    bindsym a exec --no-startup-id ddmenu $music_folder | xargs -d '\n' mpv-mp add, mode "default"
    bindsym t exec --no-startup-id mpv-mp playlist | dmenu -l 20 | xargs -d '\n' mpv-mp playlist, mode "default"
    bindsym n exec --no-startup-id mpv-mp next, mode "default"
    bindsym r exec --no-startup-id mpv-mp prev, mode "default"
    bindsym l exec --no-startup-id mpv-mp loop, mode "default"
    bindsym k exec --no-startup-id mpv-mp kill, mode "default"

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

