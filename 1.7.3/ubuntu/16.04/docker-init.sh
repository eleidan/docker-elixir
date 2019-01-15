#!/bin/sh

DOCKER_FILES_DIR="$HOME/recipes"
echo "Copying files from $DOCKER_FILES_DIR (container) to project directory (host) ..." \
  && cp -r $DOCKER_FILES_DIR/* . \
  && echo "Done."

uid=$(id -u)
if [ $uid -eq 1000 ]; then
  exit 0
fi

echo "Adopting Dockerfile for the host UID and GID" \
  && sed -i -r -e "s/1000/$(id -u)/g" \
     Dockerfile
