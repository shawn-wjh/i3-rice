configuration {
    font:       "monospace 10";
    show-icons: false;
}

* {
    background-color: {{ background }};
    text-color:       {{ foreground }};
    border-color:     {{ accent }};
}

window {
    width:         400px;
    border:        1px;
    border-radius: 0px;
    padding:       0px;
}

mainbox {
    padding:  8px;
    spacing:  6px;
    children: [inputbar, listview];
}

inputbar {
    padding:  4px 8px;
    spacing:  6px;
    children: [prompt, entry];
}

prompt {
    text-color: {{ muted }};
}

entry {
    text-color:        {{ foreground }};
    placeholder:       "";
    placeholder-color: {{ dim }};
}

listview {
    lines:     8;
    dynamic:   true;
    scrollbar: false;
    spacing:   2px;
    border-color: {{ dim }};
    border: 1px solid 0px 0px;
}

element {
    padding:       4px 8px;
    border-radius: 0px;
}

element normal.normal,
element alternate.normal {
    background-color: {{ background }};
    text-color:       {{ foreground }};
}

element selected.normal {
    background-color: {{ background }};
    text-color:       {{ foreground }};
    border:           0px 0px 0px 2px;
    border-color:     {{ highlight }};
}

element normal.urgent,
element selected.urgent {
    text-color: {{ urgent }};
}

error-message {
    padding: 40px;
}

textbox {
    text-color:       {{ color15 }};
    horizontal-align: 0.5;
    vertical-align:   0.5;
}
