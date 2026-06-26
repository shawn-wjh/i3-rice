client.focused          {{ accent }}   {{ background }}   {{ foreground }}   {{ accent }}   {{ accent }}
client.focused_inactive {{ dim }}   {{ background }}   {{ muted }}   {{ dim }}   {{ dim }}
client.unfocused        {{ surface }}   {{ background }}   {{ muted }}   {{ surface }}   {{ surface }}
client.urgent           {{ urgent }}   {{ urgent }}   {{ foreground }}   {{ urgent }}   {{ urgent }}

bar {
        status_command i3status-rs {{ HOME }}/.config/i3status/config.toml
        position top
        colors {
                background         {{ background }}
                statusline         {{ foreground }}
                separator          {{ dim }}

                focused_workspace  {{ accent }} {{ accent }} {{ background }}
                binding_mode       {{ accent }} {{ accent }} {{ background }}
                active_workspace   {{ muted }} {{ surface }} {{ foreground }}
                inactive_workspace {{ background }} {{ background }} {{ muted }}
                urgent_workspace   {{ urgent }} {{ urgent }} {{ foreground }}
        }
}
