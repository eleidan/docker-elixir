FROM eleidan/erlang:22.1.6-ubuntu-16.04

LABEL maintainer="Oleg Kulyk" \
      description="Elixir 1.9.4 based on Ubuntu 16.04" \
      init="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.9.4-ubuntu-16.04 docker-init.sh" \
      run="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.9.4-ubuntu-16.04" \
      version="2019-11-11"

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
ARG ELIXIR_VERSION="1.9.4"
ARG ELIXIR_DOWNLOAD_SHA512="f86170bde3b3ad3d1365f34f77ab9cb424c4638a4067fd7d509787c03dea0d40061ef1a2c8d1d9e42bec65b8cda8c1bf32801e4712531eeaef50e0cd53ac2369"
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
