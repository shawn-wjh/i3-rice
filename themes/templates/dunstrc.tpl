[global]
      monitor = 0
      follow = mouse
      width = 300
      height = (0, 100)
      origin = top-right
      offset = (10, 32)
      icon_theme = breeze, hicolor
      enable_recursive_icon_lookup = true
      font = Monospace 10
      frame_width = 1
      frame_color = "{{ accent }}"
      separator_color = "{{ dim }}"
      sort = yes
      idle_threshold = 120

  [urgency_low]
      background = "{{ background }}"
      foreground = "{{ muted }}"
      timeout = 5

  [urgency_normal]
      background = "{{ background }}"
      foreground = "{{ foreground }}"
      timeout = 7

  [urgency_critical]
      background = "{{ selection_background }}"
      foreground = "{{ selection_foreground }}"
      timeout = 0

[volume]
      appname = "volume"
      timeout = 2
      history_ignore = yes
      highlight = "{{ accent }}"

[brightness]
      appname = "brightness"
      timeout = 2
      history_ignore = yes
      highlight = "{{ accent }}"

[audio]
      appname = "audio"
      timeout = 2
      history_ignore = yes

[pkg]
      appname = "pkg"
      timeout = 5

[wifi]
      appname = "wifi"
      timeout = 5
