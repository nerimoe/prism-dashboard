#!/usr/bin/env bash
set -euo pipefail

# 1. Resolve commit hash (Cloudflare Pages environment or git)
REV="${CF_PAGES_COMMIT_SHA:0:7}"
if [ -z "$REV" ]; then
  REV=$(git rev-parse --short HEAD 2>/dev/null || echo "dev")
fi

echo "==> Building prism-dashboard with commit hash: $REV"

# 2. Ensure Flutter SDK is installed and in PATH
if ! command -v flutter >/dev/null 2>&1; then
  if [ ! -d "flutter" ]; then
    echo "==> Cloning Flutter SDK..."
    git clone --depth 1 -b stable https://github.com/flutter/flutter.git
  fi
  export PATH="$(pwd)/flutter/bin:$PATH"
fi

# 3. Resolve dependencies
flutter pub get

# 4. Build Flutter Web release
flutter build web --release --wasm --dart-define=PRISM_DASHBOARD_REVISION="$REV"
