#!/usr/bin/env bash

echo 'start..'

mkdir /var/factorio
mkdir /var/factorio/mods
mkdir /var/factorio/mods/graftorio3
mkdir /var/factorio/saves
mkdir /var/factorio/script-output

chown -R 1000 /var/factorio

tar xf /tmp/graftorio3/data/game/factorio.tar.xz -C /var
cp -r /tmp/graftorio3/data/game/mods /var/factorio
mount --bind /tmp/graftorio3 /var/factorio/mods/graftorio3

chown -R 1000 /var/factorio

cp /tmp/game.zip /var/factorio/saves
cp /tmp/graftorio3/docker/game/server-settings.json /var/factorio/data

cat /var/factorio/data/server-settings.json | \
  awk -v srch="GAME_NAME" -v repl="$GAME_NAME" '{ gsub(srch,repl,$0); print $0 }' > /var/factorio/data/temp.json
mv /var/factorio/data/temp.json /var/factorio/data/server-settings.json

cat /var/factorio/data/server-settings.json | \
  awk -v srch="GAME_PWD" -v repl="$GAME_PWD" '{ gsub(srch,repl,$0); print $0 }' > /var/factorio/data/temp.json
mv /var/factorio/data/temp.json /var/factorio/data/server-settings.json

chown -R 1000 /var/factorio

cp /tmp/graftorio3/docker/game/default.conf /etc/nginx/sites-available/default
service nginx restart

/var/factorio/bin/x64/factorio --start-server game.zip --server-settings /var/factorio/data/server-settings.json --rcon-bind 0.0.0.0:25575 --rcon-password $RCON_PWD
