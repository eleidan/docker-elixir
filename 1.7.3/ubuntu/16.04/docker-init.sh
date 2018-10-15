#!/bin/sh

DOCKER_DIR=".docker"

ELIXIR_MIX_DIR="$DOCKER_DIR/elixir/mix"
CONTAINER_ELIXIR_MIX_DIR="$HOME/.mix"
mkdir -p $ELIXIR_MIX_DIR
if [ -d $CONTAINER_ELIXIR_MIX_DIR ]; then
  echo "Copying files from $CONTAINER_ELIXIR_MIX_DIR (container) to $ELIXIR_MIX_DIR (host) ..." \
    && cp -r $CONTAINER_ELIXIR_MIX_DIR/* $ELIXIR_MIX_DIR \
    && echo "Done."
fi

ELIXIR_HEX_DIR="$DOCKER_DIR/elixir/hex"
CONTAINER_ELIXIR_HEX_DIR="$HOME/.hex"
mkdir -p $ELIXIR_HEX_DIR
if [ -d $CONTAINER_ELIXIR_HEX_DIR ]; then
  echo "Copying files from $CONTAINER_ELIXIR_HEX_DIR (container) to $ELIXIR_HEX_DIR (host) ..." \
    && cp -r $CONTAINER_ELIXIR_HEX_DIR/* $ELIXIR_HEX_DIR \
    && echo "Done."
fi

SCRIPTS_DIR="$DOCKER_DIR/scripts"
CONTAINER_SCRIPTS_DIR="$HOME/scripts"
echo "Copying files from $CONTAINER_SCRIPTS_DIR (container) to $SCRIPTS_DIR (host) ..." \
  && mkdir -p $SCRIPTS_DIR \
  && cp -r $CONTAINER_SCRIPTS_DIR/* $SCRIPTS_DIR \
  && echo "Done."

DOCKER_FILES_DIR="$HOME/recipes"
echo "Copying files from $DOCKER_FILES_DIR (container) to project directory (host) ..." \
  && cp -r $DOCKER_FILES_DIR/* . \
  && echo "Done."

echo "Copying files from $HOME to $DOCKER_DIR ..." \
  && cp $HOME/.bash_history $DOCKER_DIR \
  && echo "Done."
