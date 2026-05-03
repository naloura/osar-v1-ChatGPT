#!/usr/bin/env bash
# =============================================================================
# Security Impact Report (SIR) — Configuration Apply Script
# =============================================================================
# Reads config.yaml (or a path you pass as $1) and produces a configured copy
# of the source files under ./build/, with every {TOKEN} replaced by your
# organization's value.
#
# Usage:
#   ./configure.sh                 # uses ./config.yaml
#   ./configure.sh path/to/cfg.yaml
#
# Requires: python3, PyYAML  (install with: pip install pyyaml)
# =============================================================================
set -euo pipefail

CONFIG="${1:-config.yaml}"
ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILD="$ROOT/build"

if [[ ! -f "$CONFIG" ]]; then
    echo "ERROR: config file not found: $CONFIG" >&2
    echo "Hint:  cp config.example.yaml config.yaml && \$EDITOR config.yaml" >&2
    exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: python3 is required" >&2; exit 1
fi

echo "Configuring Security Impact Report toolkit..."
echo "  Source:  $ROOT"
echo "  Config:  $CONFIG"
echo "  Output:  $BUILD"
echo ""

python3 - "$ROOT" "$CONFIG" "$BUILD" <<'PYEOF'
import sys, os, re, shutil
from pathlib import Path

try:
    import yaml
except ImportError:
    sys.stderr.write("ERROR: PyYAML not installed. Run: pip install pyyaml\n")
    sys.exit(1)

root, config_path, build = sys.argv[1], sys.argv[2], sys.argv[3]
root, build = Path(root), Path(build)

with open(config_path) as f:
    cfg = yaml.safe_load(f)

# Flatten nested keys (POLICY_REF: { acceptable_use: ... } -> POLICY_REF:acceptable_use)
flat = {}
for k, v in cfg.items():
    if isinstance(v, dict):
        for sub, val in v.items():
            flat[f"{k}:{sub}"] = str(val)
    else:
        flat[k] = str(v)

# Build replacement table — token -> value
# Sort by key length descending so longer tokens match before shorter ones
tokens = sorted(flat.items(), key=lambda kv: -len(kv[0]))

def substitute(text):
    for tok, val in tokens:
        text = text.replace("{" + tok + "}", val)
    return text

# Validate that every {TOKEN} in the source has a config entry
files_to_process = []
for ext in ("*.md", "*.yaml", "*.txt"):
    files_to_process += list(root.rglob(ext))
files_to_process = [f for f in files_to_process
                    if "build" not in f.parts
                    and not f.name.startswith(".")
                    and f.name not in ("config.yaml", "config.example.yaml")]

unresolved = set()
token_re = re.compile(r"\{([A-Z_][A-Z0-9_]*(?::[a-z_]+)?)\}")
for f in files_to_process:
    text = f.read_text(errors="ignore")
    for m in token_re.finditer(text):
        if m.group(1) not in flat:
            unresolved.add(m.group(1))

if unresolved:
    sys.stderr.write("WARNING: tokens used in source files but missing from config:\n")
    for t in sorted(unresolved):
        sys.stderr.write(f"  {{{t}}}\n")
    sys.stderr.write("These tokens will pass through unchanged.\n\n")

# Wipe and recreate build dir
if build.exists():
    shutil.rmtree(build)
build.mkdir(parents=True)

processed = 0
for src in files_to_process:
    rel = src.relative_to(root)
    dst = build / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    if src.suffix in (".md", ".yaml", ".txt"):
        dst.write_text(substitute(src.read_text()))
    else:
        shutil.copy2(src, dst)
    processed += 1

# Also copy LICENSE, .gitignore, etc. as-is
for special in ("LICENSE", ".gitignore"):
    sp = root / special
    if sp.exists():
        shutil.copy2(sp, build / special)
        processed += 1

print(f"  Configured {processed} files into {build}/")
print(f"  {len(flat)} tokens applied across the toolkit.")
PYEOF

echo ""
echo "Done. Load build/Security_Impact_Report_AI_Instructions.md and"
echo "build/modules/ into your AI assistant to begin."
