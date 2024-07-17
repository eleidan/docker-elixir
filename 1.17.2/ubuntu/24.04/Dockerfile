FROM eleidan/erlang:27.0-ubuntu-24.04

LABEL maintainer="Oleg Kulyk" \
      description="Elixir 1.17.2 based on Ubuntu 24.04" \
      init="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.17.2-ubuntu-24.04 docker-init.sh" \
      run="docker run -it --rm --user $(id -u) -v $(pwd):/home/phantom/app eleidan/elixir:1.17.2-ubuntu-24.04" \
      version="2024-07-17"

WORKDIR $HOME/app

COPY docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

# Set up locales with utf-8 support
RUN apt-get update && apt-get install -y --no-install-recommends \
      locales \
    && rm -rf /var/lib/apt/lists/*

ENV LANG="C.UTF-8" \
    LANGUAGE="en_US"

RUN echo $LANG UTF-8 > /etc/locale.gen \
    && locale-gen \
    && update-locale

# Elixir
ARG ELIXIR_VERSION="1.17.2"
RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="7bb8e6414b77c1707f39f620a2ad54f68d64846d663ec78069536854247fb1ab" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete


### Needed for the docker-init.sh script
COPY --chown=phantom:phantom recipes $HOME/recipes

ENV SERVICE_NAME="Elixir ${ELIXIR_VERSION} on Ubuntu 24.04"
USER phantom
