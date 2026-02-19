#!/bin/bash
set -e

cd "$(dirname "$0")"

if [ -f VERSION ]; then
  zhmVersion=$(<VERSION)
else
  zhmVersion="devel"
fi

zhmRevision=$(git log -1 --pretty=format:"%h(%ai)")
zhmRevision="${zhmRevision:0:18})"

FLAGS="-ldflags \"-X main.Version=$zhmVersion -X main.Revision=$zhmRevision\""

# 自动检测当前系统和架构
GOOS=$(go env GOOS)
GOARCH=$(go env GOARCH)

echo "Detected GOOS=$GOOS GOARCH=$GOARCH"

# 构建输出目录
outdir="bin/${GOOS}_${GOARCH}"
mkdir -p "$outdir"

cmd=$(echo "go build $FLAGS -o $outdir/zhmakeindex")
eval $cmd

