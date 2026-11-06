#!/usr/bin/env bash
# Point one plugin's entry at a release: its tag and that tag's commit.
#
#   scripts/pin.sh dashline v0.2.0
#
# Users get exactly that commit, even if the tag later moves. The script checks that the
# tag's plugin.json carries the tag's version, writes `ref` and `sha` into the entry,
# and validates the marketplace. It doesn't commit.
set -euo pipefail

plugin=${1:?usage: scripts/pin.sh PLUGIN TAG}
tag=${2:?usage: scripts/pin.sh PLUGIN TAG}
cd "$(dirname "$0")/.."
file=.claude-plugin/marketplace.json

repo=$(python3 - "$file" "$plugin" <<'EOF'
import json, sys
entries = [p for p in json.load(open(sys.argv[1], encoding="utf-8"))["plugins"]
           if p["name"] == sys.argv[2]]
if not entries:
    sys.exit(f"no plugin named {sys.argv[2]!r} in {sys.argv[1]}")
source = entries[0]["source"]
if not isinstance(source, dict) or source.get("source") != "github":
    sys.exit(f"{sys.argv[2]}'s source isn't a github repo")
print(source["repo"])
EOF
)

# The commit the tag names: the peeled line (^{}) for an annotated tag, else the tag's own.
refs=$(git ls-remote "https://github.com/$repo.git" "refs/tags/$tag" "refs/tags/$tag^{}")
sha=$(awk '/\^\{\}$/ {print $1}' <<<"$refs")
[ -n "$sha" ] || sha=$(awk 'NR==1 {print $1}' <<<"$refs")
if [ -z "$sha" ]; then
  echo "pin.sh: $repo has no tag $tag" >&2
  exit 1
fi

# The release must be the version it says it is: Claude Code updates on that field.
manifest="https://raw.githubusercontent.com/$repo/$sha/.claude-plugin/plugin.json"
version=$(curl -fsSL "$manifest" | python3 -c 'import json, sys; print(json.load(sys.stdin)["version"])')
if [ "v$version" != "$tag" ] && [ "$version" != "$tag" ]; then
  echo "pin.sh: $tag's plugin.json says version $version" >&2
  exit 1
fi

python3 - "$file" "$plugin" "$tag" "$sha" <<'EOF'
import json, sys
path, name, tag, sha = sys.argv[1:]
with open(path, encoding="utf-8") as f:
    data = json.load(f)
for entry in data["plugins"]:
    if entry["name"] == name:
        repo = entry["source"]["repo"]
        entry["source"] = {"source": "github", "repo": repo, "ref": tag, "sha": sha}
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write("\n")
EOF

echo "$plugin → $repo $tag (${sha:0:7}, version $version)"
if command -v claude >/dev/null; then
  claude plugin validate . | tail -1
fi
