# claude-toolbox

A Claude Code plugin marketplace for Mason Flint's plugins. Four so far:

| Plugin | What | Repo |
|---|---|---|
| `dashline` | one statusline for every plan (Free through Enterprise, API key): session, context and prompt cache, plan-limit bars, and a git row | [claude-dashline](https://github.com/MasonFlint44/claude-dashline) |
| `pins` | pin sessions and resume them by name: a `pins` terminal picker (fzf) plus `/pins:pin` and `/pins:unpin` | [claude-pins](https://github.com/MasonFlint44/claude-pins) |
| `spend-statusline` | for organization and Team plans with spend billing: daily and monthly spend bars from the `/usage` numbers, plus a work-week and holiday calendar | [claude-spend-statusline](https://github.com/MasonFlint44/claude-spend-statusline) |
| `usage-statusline` | for Pro and Max plans: 5-hour, 7-day and Fable usage bars with reset countdowns (interim release; Linux, WSL and Git Bash only) | [claude-usage-statusline](https://github.com/MasonFlint44/claude-usage-statusline) |

## Install

```
/plugin marketplace add MasonFlint44/claude-toolbox
/plugin install dashline@claude-toolbox
/plugin install pins@claude-toolbox
/plugin install spend-statusline@claude-toolbox
/plugin install usage-statusline@claude-toolbox
```

then follow each plugin's own README (`/dashline:install` for `dashline`,
`/pins:install` for `pins`,
`/spend-statusline:install` for `spend-statusline`,
`/usage-statusline:install` for `usage-statusline`; the statuslines
replace each other, so install one). Updates:
`/plugin update <plugin>`, or turn on auto-update for this marketplace in `/plugin`.

Each plugin lives in its own repository with its own tests, changelog and
releases; this repository only lists them. Each entry is pinned to a release:
its tag (`ref`) and that tag's commit (`sha`), so users get exactly what was
released, never work in progress on a plugin's `main`. Entries carry no
`version`: Claude Code reads it from each plugin's own `plugin.json` (the docs
warn against setting it in both places).

## Releasing a plugin

After tagging and releasing `vX.Y.Z` in the plugin's own repository:

```
scripts/pin.sh <plugin> vX.Y.Z    # checks the tag's plugin.json says X.Y.Z, writes ref and sha, validates
git commit -am "Pin <plugin> to vX.Y.Z" && git push
```

Users get it on their next `/plugin update`, or by auto-update.
