# hyprnav

Seamlessly navigate between
[Hyprland](https://hypr.land/) windows,
[Kitty](https://sw.kovidgoyal.net/kitty/) windows and
[Neovim](https://neovim.io/) windows (of a Kitty-hosted Neovim)
using the same key combinations, e.g., `Super+h/j/k/l`.

The keys are bound to a script in the hyprland config that relays keys to a Kitty instance in the focused window or, if present, a Neovim instance that runs in Kitty. A small Neovim plugin ensures that navigating inside Neovim as well as 'leaving' Neovim works as intended.



## Requirements

  - hyprland 0.55+ (after they switched to Lua)
  - Bash
  - Kitty 0.4+
  - Neovim 0.10+



## Install / Setup

### Neovim

Clone the repository into a [Neovim package directory](https://neovim.io/doc/user/pack/)), e.g., `~/.config/nvim/pack/ext/start/` or use a Neovim plugin manager like [lazy.nvim](https://github.com/folke/lazy.nvim).


### Kitty

Modify your `kitty.conf` as follows:

```conf
allow_remote_control socket-only
listen_on unix:${XDG_RUNTIME_DIR}/kitty-{kitty_pid}
````

Note that these changes require a full Kitty restart, not just a config reload.


### Hyprland

1. Copy or symlink the bash script `bin/navigate` from this repo wherever you like, e.g., to `~/.local/bin/`.


2. Add keybindings to your config (make sure the path to the `navigate` script is correct):

```lua
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.bind("SUPER + H", "Focus on left window",  hl.dsp.exec_cmd("~/.local/bin/navigate h"))
hl.bind("SUPER + J", "Focus on below window", hl.dsp.exec_cmd("~/.local/bin/navigate j"))
hl.bind("SUPER + K", "Focus on above window", hl.dsp.exec_cmd("~/.local/bin/navigate k"))
hl.bind("SUPER + L", "Focus on right window", hl.dsp.exec_cmd("~/.local/bin/navigate l"))
```





