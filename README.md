# claude-statuslines

A Claude Code plugin marketplace for statuslines. One so far:

| Plugin | For | Repo |
|---|---|---|
| `budget-statusline` | organization and Team plans with spend billing: daily and monthly budget bars from the `/usage` numbers, plus a work-week and holiday calendar | [claude-budget-statusline](https://github.com/MasonFlint44/claude-budget-statusline) |

A plan-user statusline (5-hour and weekly windows rather than dollars) is
planned as a second plugin.

## Install

```
/plugin marketplace add MasonFlint44/claude-statuslines
/plugin install budget-statusline@claude-statuslines
```

then follow the plugin's own README (for `budget-statusline`, run
`/install-statusline`). Updates: `/plugin update budget-statusline`, or
turn on auto-update for this marketplace in `/plugin`.

Each plugin lives in its own repository with its own tests, changelog and
releases; this repository only lists them.
