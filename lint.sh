#!/usr/bin/env bash

err=0
err_handler() {
  err=1
}
trap err_handler ERR

moonc lint_config.moon

echo '## BEGIN LUACHECK LINTS ##'

luacheck . -q --codes

echo '## END LUACHECK LINTS ##'
echo '## BEGIN MOONPICK LINTS ##'

for f in `find src spec -type f -name "*.moon"`; do
  moonpick "$f"
done

echo '## END MOONPICK LINTS ##'

exit $err
