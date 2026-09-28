# Omalock

A one-click Omarchy bar widget that locks your window layout.

![Locked and unlocked states](screenshots/bar-states.png)

Click the lock glyph in the bar to toggle:

- **Locked** (`󰌾`): moving, resizing, swapping, floating, grouping, and
  sending windows to other workspaces are all disabled.
- **Unlocked** (`󰌿`): normal Hyprland window management.

## How it works

Locking calls `hyprctl eval "hl.unbind(...)"` at runtime for every keybind
and mouse bind that mutates window geometry or placement (see `bin/omalock`
for the exact list). Unlocking runs `hyprctl reload`, which restores the full
config from `~/.config/hypr/`.

The lock is global: while active it applies to every workspace, so you cannot
move or resize windows on any workspace, nor move windows between them. State
is stored in `${XDG_STATE_HOME:-~/.local/state}/omalock/state`.

## CLI

```bash
bin/omalock lock      # lock
bin/omalock unlock    # unlock
bin/omalock toggle    # toggle
bin/omalock status    # prints "locked" or "unlocked"
```

## Screenshots

Unlocked (open padlock) vs locked (red padlock):

![Unlocked](screenshots/bar-unlocked.png)
![Locked](screenshots/bar-locked.png)

On a workspace with a tiled layout, locking freezes every window in place:

![Desktop with layout locked](screenshots/desktop-locked.png)

## Notes

- Focus, workspace switching, and fullscreen are intentionally left enabled.
- Custom move/resize keybinds added outside the stock Omarchy set are not
  covered; add their combos to `combos()` in `bin/omalock`.
