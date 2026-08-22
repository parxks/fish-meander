# fish-meander

Fish-native directory navigation with intelligent child ordering.

## Requirements

- Fish 3.5+
- `fzf` for `Alt+Shift+Down`
- `eza` is optional; it is used for the FZF preview when available

## Install with Fisher

```fish
fisher install <your-user>/fish-meander
```

For local development:

```fish
fisher install ~/development/fish-plugins/fish-meander
```

## Default bindings

| Binding | Action |
|---|---|
| `Alt+Up` | Parent directory, unless a Meander child-cycle session is active; then previous child |
| `Alt+Down` | Next intelligently ordered child; one child is entered immediately |
| `Alt+Shift+Down` | FZF child-directory picker |
| `Alt+Left` | Fish `prevd` |
| `Alt+Right` | Fish `nextd` |

## Child-cycle context

After `Alt+Down`, Meander enters a temporary sibling-navigation context.

`Alt+Up` then moves backward through the same child list instead of going to the parent.

The context ends when:

- 15 seconds pass without another Meander navigation keypress
- the commandline is cleared
- the selected directory is actually entered
- the current directory changes outside the cycle

The timeout is an inactivity timeout and is refreshed by each Meander navigation action.

Configure it with:

```fish
set -U meander_cycle_timeout 15
```

## Intelligent ordering

Children are ordered using:

1. last-selected child for this parent
2. favorite directories
3. visit frequency
4. recent visits
5. project-root markers
6. alphabetical path order as the deterministic fallback

The same ordering is used by cycling and FZF.

## Favorites

Add the current directory:

```fish
meander favorite add
```

Add an explicit path:

```fish
meander favorite add ~/Projects
```

List:

```fish
meander favorite list
```

Remove:

```fish
meander favorite remove ~/Projects
```

Jump with FZF:

```fish
meander favorite jump
```

## Commands

```text
meander --help
meander status
meander clear
meander favorite add [PATH]
meander favorite remove [PATH]
meander favorite list
meander favorite jump
meander root
meander config
meander doctor
```

## Configuration

```fish
set -U meander_cycle_timeout 15
set -U meander_show_hidden false
set -U meander_fzf_preview true
set -U meander_sort_mode intelligent
```

`meander_show_hidden` controls whether hidden child directories are included.

`meander_fzf_preview` controls the FZF preview.

`meander_sort_mode` currently accepts `intelligent` or `alphabetical`.

## Notes

Meander does not wrap or replace `cd`, does not maintain a replacement for Fish directory history, and does not use `ls`/`find` parsing.
