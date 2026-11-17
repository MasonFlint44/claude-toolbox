# claude-toolbox

A Claude Code plugin marketplace for Mason Flint's plugins. One so far:

| Plugin | What | Repo |
|---|---|---|
| `dashline` | one statusline for every plan (Free through Enterprise, API key): session, context and prompt cache, plan-limit bars, and a git row | [claude-dashline](https://github.com/MasonFlint44/claude-dashline) |

The older `spend-statusline`, `usage-statusline` and `pins` plugins are no
longer listed: `dashline` replaces the statuslines, and
[claude-launcher](https://github.com/MasonFlint44/claude-launcher) replaces
`pins`. If you have one installed, remove it with `/plugin uninstall <plugin>`.

## Install

```
/plugin marketplace add MasonFlint44/claude-toolbox
/plugin install dashline@claude-toolbox
```

then run `/dashline:install` (see the
[dashline README](https://github.com/MasonFlint44/claude-dashline)). Updates:
`/plugin update dashline`, or turn on auto-update for this marketplace in `/plugin`.

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
