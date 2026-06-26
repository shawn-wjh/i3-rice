#!/usr/bin/env python3
"""Hide titlebars when a workspace has only one tiled window."""
import json
import subprocess
import sys


def i3_msg(*args):
    return subprocess.run(
        ["i3-msg", *args],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    ).stdout


def tiled_leaves(container):
    leaves = []
    stack = list(reversed(container.get("nodes", [])))

    while stack:
        node = stack.pop()
        if node.get("window") is not None:
            leaves.append(node)
        stack.extend(reversed(node.get("nodes", [])))

    return leaves


def workspaces(container):
    if container.get("type") == "workspace":
        yield container

    for child in container.get("nodes", []):
        yield from workspaces(child)


def update_borders():
    tree = json.loads(i3_msg("-t", "get_tree"))

    for workspace in workspaces(tree):
        tiled = tiled_leaves(workspace)
        style = "pixel 1" if len(tiled) == 1 else "normal"

        for window in tiled:
            i3_msg(f'[con_id="{window["id"]}"]', "border", style)


def main():
    update_borders()

    if "--once" in sys.argv:
        return

    events = json.dumps(["window", "workspace"])
    with subprocess.Popen(
        ["i3-msg", "-t", "subscribe", "-m", events],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    ) as subscription:
        for _ in subscription.stdout:
            update_borders()


if __name__ == "__main__":
    main()
