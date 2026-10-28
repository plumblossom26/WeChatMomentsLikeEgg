#!/bin/zsh
set -euo pipefail

ROOT="${0:A:h}"
cd "$ROOT"
export THEOS="${THEOS:-/opt/theos}"

finish() {
  exit_code=$?
  trap - EXIT
  echo
  if (( exit_code == 0 )); then
    echo "✅ 打包完成：$ROOT/packages"
    [[ "${MLM_NO_OPEN:-0}" == 1 ]] || open "$ROOT/packages" || true
  else
    echo "❌ 打包失败，退出码：$exit_code"
  fi
  if [[ -t 0 ]]; then
    echo "按任意键关闭窗口…"
    read -k 1
  fi
  exit "$exit_code"
}
trap finish EXIT

./package-all.sh
