#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/packages"
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/momentslikeegg-debs.XXXXXX")"
export THEOS="${THEOS:-/opt/theos}"

cleanup() {
  rm -rf "$STAGE"
}
trap cleanup EXIT

[[ -d "$THEOS" ]] || { echo "THEOS 不存在：$THEOS"; exit 1; }

cd "$ROOT"
rm -rf "$OUT"
mkdir -p "$OUT"

build_one() {
  local scheme="$1"
  echo "==> 构建 $scheme"
  make clean
  rm -f "$OUT"/*.deb
  make FINALPACKAGE=1 SCHEME="$scheme" package
  local deb
  deb="$(find "$OUT" -maxdepth 1 -name 'com.qimiao.momentslikeegg_*.deb' -type f | head -1)"
  [[ -n "$deb" ]] || { echo "没有生成 deb：$scheme"; exit 1; }
  cp "$deb" "$STAGE/"
}

build_one rootless
build_one rootful
build_one roothide

rm -rf "$OUT"
mkdir -p "$OUT"
mv "$STAGE"/*.deb "$OUT/"

echo
echo "==> 产物"
ls -la "$OUT"
echo
for deb in "$OUT"/*.deb; do
  echo "$(basename "$deb"): $(dpkg-deb -f "$deb" Architecture)"
done
echo
echo "无根(默认): iphoneos-arm64"
echo "有根:       iphoneos-arm"
echo "隐根:       iphoneos-arm64e（dylib 仍是 arm64）"
