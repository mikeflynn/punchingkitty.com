#!/bin/sh
USER="mikeflynn"
HOST="carlin.flynn.link"
DIR="/home/www/punchingkitty.com/public/"

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}

exit 0
