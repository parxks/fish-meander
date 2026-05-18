```markdown
# 🌊 meander.fish

A fluid, context-aware navigation engine for the **Fish shell** that lets you slide through your file system like a breeze. Instead of constantly typing `cd ..`, `ls`, or `git status`, `meander` binds your directory tree to intuitive `Alt` key combinations that adapt to your exact environment.

Built natively for Fish, utilizing modern event handling and asynchronous lazy-loading to keep your shell startup snappy.

> **Meander** *(noun / verb)*
> The natural looping, bending, and shifting of a fast-moving current when it hits physical boundaries. Instead of a rigid, straight-line trajectory, a meander adapts its flow dynamically based on the local terrain.

## 🚀 Speed Navigation

*   **`Alt + Up`**: Escape to the parent directory (`cd ..`).
*   **`Alt + Down`**: Smart Action. Scans the local boundary and runs the best contextual command (Git status, `ls`, `tree`, or project maps).
*   **`Alt + Left`**: Trace your steps backward through your directory history stack.
*   **`Alt + Right`**: Move forward through your navigation history stack.

## 📦 Installation

Drop the files straight into your local configuration layout:

```fish
fisher install phorestsdownstream/fish-meander

```


```fish
# Copy or symlink into your native Fish directories
cp conf.d/meander.fish ~/.config/fish/conf.d/
cp functions/*.fish ~/.config/fish/functions/
cp completions/*.fish ~/.config/fish/completions/

```

*Or install via Fisher (coming soon).*

## 🎮 Configurations

Meander runs intelligently out of the box, but you can set universal variables in your shell to tweak behaviors:

```fish
set -U meander_smart_mode auto  # Choices: auto, git, tree, ls, fzf, project
set -U meander_max_history 100  # Cap the history memory stack
set -U meander_auto_track true   # Toggle background tracking

```

## 🛠️ Diagnostics

* `meander_status`: View your current backward/forward history depth and active modes.
* `meander_clear`: Purge the current navigation stacks.

```

---

## Under the Hood: What the Functions Actually Do

Since we refactored everything into split files, here is exactly what those specific background/smart actions are pulling off when you smash `Alt+Down` or change directories:

### 1. `_meander_trim_history`
*   **What it does:** Memory management. Every time you change directories, your history stack grows. This function is a structural janitor—it watches the counts of your `meander_history_back` and `meander_history_forward` universal arrays. If they exceed your configured max limit (default `100`), it chops off the oldest entries (`[1..-2]`) so your shell variables never bloat.

### 2. Context Actions (The `Alt+Down` Matrix)
When you hit `Alt+Down`, `meander_smart_down` evaluates your current workspace and passes the torch to one of these dedicated logic-handlers:

*   **`_meander_git_action`**
    *   **What it does:** If you are inside a Git repository, it pulls a clean summary of your workspace (`git status -sb`), counts your total commits, and explicitly prints a warning flag (`⚠️`) if you have uncommitted changes floating around.
*   **`_meander_fzf_action`**
    *   **What it does:** If your smart mode is set to `fzf` (and you have `fzf` installed), it quickly maps out all immediate subdirectories and opens a fuzzy-finder menu with a live `ls -la` preview pane. You can fuzzy-match a folder, hit Enter, and instantly jump straight into it.
*   **`_meander_project_action`**
    *   **What it does:** Scans up to 3 levels deep looking for specific project anchor files (`.git`, `package.json`, `Cargo.toml`, etc.). If it detects them, it lists them numerically. You just type the number, and it warps you directly to that project's root directory.
*   **`_meander_ls_action`**
    *   **What it does:** The reliable fallback. It executes a clean, structured directory layout list. It forces directories to group first, colors the output natively, and safely falls back to standard `ls -la` if your system flags vary.
*   **`_meander_empty_action`**
    *   **What it does:** Scaffold utility. If you enter a completely barren directory, it halts and prompts you with a quick `y/n`. If you confirm, it auto-generates a clean developer skeleton project layout (`src/`, `docs/`, `tests/`, `README.md`, `.gitignore`, etc.) so you can start coding instantly.

```
