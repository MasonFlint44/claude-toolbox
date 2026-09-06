# claude-toolbox

A Claude Code plugin marketplace for Mason Flint's plugins. Two so far:

| Plugin | What | Repo |
|---|---|---|
| `pins` | pin sessions and resume them by name: a `pin` terminal picker (fzf) plus `/pins:pin` and `/pins:unpin` | [claude-pins](https://github.com/MasonFlint44/claude-pins) |
| `budget-statusline` | for organization and Team plans with spend billing: daily and monthly budget bars from the `/usage` numbers, plus a work-week and holiday calendar | [claude-budget-statusline](https://github.com/MasonFlint44/claude-budget-statusline) |

A plan-user statusline (5-hour and weekly windows rather than dollars) is
planned as a third plugin.

## Install

```
/plugin marketplace add MasonFlint44/claude-toolbox
/plugin install pins@claude-toolbox
/plugin install budget-statusline@claude-toolbox
```

then follow each plugin's own README (`/pins:install` for `pins`,
`/budget-statusline:install` for `budget-statusline`). Updates:
`/plugin update <plugin>`, or turn on auto-update for this marketplace in `/plugin`.

Each plugin lives in its own repository with its own tests, changelog and
releases; this repository only lists them. Entries carry no `version`: Claude
Code reads it from each plugin's own `plugin.json`, so a plugin release needs
no change here (the docs warn against setting it in both places).
