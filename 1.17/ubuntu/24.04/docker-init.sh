#!/bin/sh

DOCKER_FILES_DIR="$HOME/recipes"
echo "Copying files from $DOCKER_FILES_DIR (container) to project directory (host) ..." \
  && cp -r $DOCKER_FILES_DIR/* . \
  && echo "Done."
