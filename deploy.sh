#!/usr/bin/env bash

USER="mikeflynn"
HOST="carlin"
DIR="/home/www/punchingkitty.com/public/"

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}

exit 0
