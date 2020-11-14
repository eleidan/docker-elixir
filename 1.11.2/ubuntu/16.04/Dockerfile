FROM eleidan/erlang:23.1-ubuntu-16.04

LABEL maintainer="Oleg Kulyk" \
      description="Elixir 1.11.2 based on Ubuntu 16.04" \
      init="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.11.2-ubuntu-16.04 docker-init.sh" \
      run="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.11.2-ubuntu-16.04" \
      version="2020-11-15"

WORKDIR $HOME/app

COPY docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

# Set up locales with utf-8 support
RUN apt-get update && apt-get install -y --no-install-recommends \
      locales \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US

RUN echo $LANG UTF-8 > /etc/locale.gen \
    && locale-gen \
    && update-locale

# Elixir
ARG ELIXIR_VERSION="1.11.2"
ARG ELIXIR_DOWNLOAD_SHA512="7b6ece70d2db6cf4b02c3e72f0ae2edc68e13a2651876525eab08e3c3c3f1f88d294e3f412c3fb736bc84ba4c2897930101b0ac715e322f1554f29c69e2d1e77"
RUN set -xe \
    && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip" \
    && buildDeps=' \
        unzip \
        ' \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${buildDeps} \
    && curl -fSL -o elixir-precompiled.zip ${ELIXIR_DOWNLOAD_URL} \
    && echo "${ELIXIR_DOWNLOAD_SHA512} elixir-precompiled.zip" | sha512sum -c - \
    && unzip -d /usr/local elixir-precompiled.zip \
    && rm elixir-precompiled.zip \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

### Needed for the docker-init.sh script
COPY --chown=phantom:phantom recipes $HOME/recipes

ENV SERVICE_NAME="Elixir ${ELIXIR_VERSION} on Ubuntu 16.04"
USER phantom
