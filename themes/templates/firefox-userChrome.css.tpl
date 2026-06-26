:root {
  --i3-theme-background: {{ background }};
  --i3-theme-foreground: {{ foreground }};
  --i3-theme-accent: {{ accent }};
  --i3-theme-surface: {{ surface }};
  --i3-theme-muted: {{ muted }};
  --i3-theme-dim: {{ dim }};
  --i3-theme-urgent: {{ urgent }};
  --i3-theme-selection-background: {{ selection_background }};
  --i3-theme-selection-foreground: {{ selection_foreground }};

  --focus-outline-color: var(--i3-theme-accent) !important;
  --in-content-focus-outline-color: var(--i3-theme-accent) !important;
  --toolbar-bgcolor: var(--i3-theme-background) !important;
  --toolbar-color: var(--i3-theme-foreground) !important;
  --lwt-accent-color: var(--i3-theme-background) !important;
  --lwt-text-color: var(--i3-theme-foreground) !important;
  --lwt-toolbar-field-background-color: var(--i3-theme-surface) !important;
  --lwt-toolbar-field-color: var(--i3-theme-foreground) !important;
  --lwt-toolbar-field-border-color: var(--i3-theme-dim) !important;
  --lwt-toolbar-field-focus: var(--i3-theme-background) !important;
  --lwt-toolbar-field-focus-color: var(--i3-theme-foreground) !important;
  --tab-selected-bgcolor: var(--i3-theme-surface) !important;
  --tab-selected-color: var(--i3-theme-foreground) !important;
}

#navigator-toolbox,
#TabsToolbar,
#nav-bar,
#PersonalToolbar,
#titlebar {
  background: var(--i3-theme-background) !important;
  color: var(--i3-theme-foreground) !important;
  border-color: var(--i3-theme-dim) !important;
}

.tabbrowser-tab .tab-background {
  background: var(--i3-theme-background) !important;
  border-color: transparent !important;
}

.tabbrowser-tab[selected="true"] .tab-background,
.tabbrowser-tab[multiselected="true"] .tab-background {
  background: var(--i3-theme-surface) !important;
  border: 1px solid var(--i3-theme-accent) !important;
}

.tabbrowser-tab,
.tab-label,
.toolbarbutton-1,
#urlbar,
#searchbar {
  color: var(--i3-theme-foreground) !important;
}

#urlbar-background,
#searchbar {
  background: var(--i3-theme-surface) !important;
  border-color: var(--i3-theme-dim) !important;
}

#urlbar[focused="true"] > #urlbar-background {
  border-color: var(--i3-theme-accent) !important;
}

toolbarseparator,
toolbarbutton,
.toolbarbutton-icon,
.toolbarbutton-text {
  color: var(--i3-theme-foreground) !important;
  fill: var(--i3-theme-foreground) !important;
}

menupopup,
panel,
panelview {
  --panel-background: var(--i3-theme-background) !important;
  --panel-color: var(--i3-theme-foreground) !important;
  --panel-border-color: var(--i3-theme-dim) !important;
}

::selection {
  background: var(--i3-theme-selection-background) !important;
  color: var(--i3-theme-selection-foreground) !important;
}

*:focus-visible {
  outline-color: var(--i3-theme-accent) !important;
}
