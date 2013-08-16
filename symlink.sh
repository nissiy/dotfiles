#!/bin/sh
cd `dirname $0`

for file in .?*
do
  if [ $file != '..' ] && [ $file != '.git' ]; then
    ln -is "$PWD/$file" $HOME
  fi
done
