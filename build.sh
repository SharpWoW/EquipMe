#!/bin/sh

rsync -a --prune-empty-dirs --include '*/' --include '*.lua' --exclude '*' src/ out/

(
  cd src
  moonc -t ../out **.moon
)
