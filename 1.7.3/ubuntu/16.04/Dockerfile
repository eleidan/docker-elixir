FROM eleidan/erlang:22.1.6-ubuntu-16.04

LABEL maintainer="Oleg Kulyk" \
      description="Elixir 1.7.3 based on Ubuntu 16.04" \
      init="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.7.3-ubuntu-16.04 docker-init.sh" \
      run="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.7.3-ubuntu-16.04" \
      version="2019-01-11"

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
ARG ELIXIR_VERSION="1.7.3"
ARG ELIXIR_DOWNLOAD_SHA512="f8b0ac405531d46f4b65f459970c4b82892f8db51028f172072748269a922db65cb58e36239cd26dc39e5bdebd08a0e630ecbc267b6ff55a15d188483d78a0e5"
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
