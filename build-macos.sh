#!/bin/bash
GOOS=darwin GOARCH=arm64 go build $FLAGS -o bin/darwin_arm64/zhmakeindex
