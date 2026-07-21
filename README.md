# fish-meander

Fish-native directory navigation.

## Install

```fish
fisher install user/fish-meander
```

## Keys

- Alt-Up: cd to parent
- Alt-Down: cycle child directories in command buffer
- Shift-Alt-Down: fzf child directory picker
- Alt-Left: Fish previous directory
- Alt-Right: Fish next directory

Alt-Down:
- zero children: no action
- one child: immediately enters directory
- multiple children: cycles `cd /path` in the buffer

Press Enter normally.

Requirements:
- Fish 3.5+
- fzf optional
