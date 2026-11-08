#!/bin/bash
# Builds the documentation site for GitHub Pages: the DocC catalog in
# Sources/NucleantTransitions/NucleantTransitions.docc with NucleantTransitions' symbols,
# and the Transition Gallery, built for WebAssembly, next to it.
#
#   Scripts/build-docs.sh [output-dir]
#
# Output defaults to .build/docs-site, laid out to be served at
# https://nucleantui.github.io/NucleantTransitions/ — the site's root is the
# repository's Pages path. To look at it locally:
#
#   mkdir -p /tmp/pages && ln -sfn "$PWD/.build/docs-site" /tmp/pages/NucleantTransitions
#   uv run --no-project python -m http.server -d /tmp/pages 8000
#   open http://localhost:8000/NucleantTransitions/
#
# HOSTING_BASE_PATH (default NucleantTransitions) is that path. The gallery link
# in Articles/TransitionGallery.md is written against it, so change both
# together. SKIP_GALLERY=1 leaves the gallery out.
#
# The gallery needs a swift.org toolchain and its matching WebAssembly Swift
# SDK (https://www.swift.org/documentation/articles/wasm-getting-started.html):
# SWIFT_TOOLCHAIN (default 6.3.3) names the toolchain in
# ~/Library/Developer/Toolchains. It is built by NucleantApplication's
# scripts/build_wasm_app.py, from the checkout this package resolves, and run
# with uv.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUTPUT="$(mkdir -p "${1:-$ROOT/.build/docs-site}" && cd "${1:-$ROOT/.build/docs-site}" && pwd)"
BASE_PATH="${HOSTING_BASE_PATH:-NucleantTransitions}"
CATALOG="$ROOT/Sources/NucleantTransitions/NucleantTransitions.docc"
GRAPHS="$ROOT/.build/symbol-graphs"
MODULE_GRAPHS="$ROOT/.build/symbol-graphs-NucleantTransitions"

# 1. NucleantTransitions' symbol graphs: its own, and its extensions to
#    NucleantUI's types (each transition's `.name` spellings on `Transition`
#    and `AnyTransition`). The flags reach every module
#    the build compiles, so only NucleantTransitions' graphs are kept for DocC.
echo "Extracting NucleantTransitions' symbols…"
rm -rf "$GRAPHS" "$MODULE_GRAPHS"
mkdir -p "$GRAPHS" "$MODULE_GRAPHS"
cd "$ROOT"
swift build --target NucleantTransitions \
    -Xswiftc -emit-symbol-graph \
    -Xswiftc -emit-symbol-graph-dir -Xswiftc "$GRAPHS" \
    -Xswiftc -symbol-graph-minimum-access-level -Xswiftc public
cp "$GRAPHS"/NucleantTransitions.symbols.json "$MODULE_GRAPHS"/
cp "$GRAPHS"/NucleantTransitions@*.symbols.json "$MODULE_GRAPHS"/ 2>/dev/null || true

# 2. The catalog, converted for static hosting under /$BASE_PATH/.
echo "Converting the catalog…"
rm -rf "$OUTPUT"
xcrun docc convert "$CATALOG" \
    --fallback-display-name NucleantTransitions \
    --fallback-bundle-identifier org.nucleantui.NucleantTransitions \
    --additional-symbol-graph-dir "$MODULE_GRAPHS" \
    --transform-for-static-hosting \
    --hosting-base-path "$BASE_PATH" \
    --output-path "$OUTPUT"

# The site's root opens the documentation rather than DocC's empty route.
cat > "$OUTPUT/index.html" <<EOF
<!DOCTYPE html>
<meta charset="utf-8">
<title>NucleantTransitions</title>
<meta http-equiv="refresh" content="0; url=/$BASE_PATH/documentation/nucleanttransitions/">
<link rel="canonical" href="/$BASE_PATH/documentation/nucleanttransitions/">
<a href="/$BASE_PATH/documentation/nucleanttransitions/">NucleantTransitions documentation</a>
EOF
touch "$OUTPUT/.nojekyll"

# 3. The gallery, served at /$BASE_PATH/gallery/.
if [ "${SKIP_GALLERY:-0}" != "1" ]; then
    echo "Building the gallery for WebAssembly…"
    SWIFT="$HOME/Library/Developer/Toolchains/swift-${SWIFT_TOOLCHAIN:-6.3.3}-RELEASE.xctoolchain/usr/bin/swift"
    # The shaders, compiled here for the host: the wasm build cannot build
    # PyShader's plugin, and takes them as resources instead (Package.swift).
    swift package --package-path "$ROOT" --allow-writing-to-package-directory pyshader-compile
    WASM_SCRATCH="$ROOT/.build/wasm"
    # The checkouts the wasm build uses, so the build script and the page
    # runtime come from the NucleantApplication this package resolves.
    WASM_BUILD=1 "$SWIFT" package resolve --package-path "$ROOT" --scratch-path "$WASM_SCRATCH"
    uv run --no-project python "$WASM_SCRATCH/checkouts/NucleantApplication/scripts/build_wasm_app.py" \
        TransitionGallery --package-path "$ROOT" --release --output "$OUTPUT/gallery"
    # GitHub Pages serves .wasm uncompressed; the page runtime inflates a
    # module whose URL ends in .gz.
    gzip -9 -f "$OUTPUT/gallery/TransitionGallery.wasm"
    sed -i '' 's|\./TransitionGallery\.wasm|./TransitionGallery.wasm.gz|' "$OUTPUT/gallery/index.html"
    sed -i '' 's|<title>TransitionGallery</title>|<title>Transition Gallery</title>|' "$OUTPUT/gallery/index.html"
fi

echo "Documentation site: $OUTPUT"
