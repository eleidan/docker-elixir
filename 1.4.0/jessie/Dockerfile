FROM eleidan/erlang:19.2-jessie
MAINTAINER Oleg Kulyk

ENV ELIXIR_VERSION="1.4.0" \
    LANG=C.UTF-8
ENV SERVICE_NAME="elixir:$ELIXIR_VERSION-jessie" \
    HOME=/home/phantom

# Elixir
RUN set -xe \
    && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip" \
    && ELIXIR_DOWNLOAD_SHA256="60d077bc242e65f4f430beb43c968b5632dfb07ec89a7d689da254ffdc791b98"\
    && buildDeps=' \
        unzip \
        ' \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && curl -fSL -o elixir-precompiled.zip $ELIXIR_DOWNLOAD_URL \
    && echo "$ELIXIR_DOWNLOAD_SHA256 elixir-precompiled.zip" | sha256sum -c - \
    && unzip -d /usr/local elixir-precompiled.zip \
    && rm elixir-precompiled.zip \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME/app

### Provide end users with handy init script
# Can be used as follows:
#   docker run -it --rm -v $(pwd):/home/phantom/app eleidan/elixir:<version>-<flavor> docker-init.sh
# NOTE: Replace <version> with actual ruby version,
#       and <flavor> with actual linux distro flavor.
# EXAMPLE:
# docker run -it --rm -v $(pwd):/home/phantom/app eleidan/elixir:1.4.0-jessie docker-init.sh
COPY docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

### Needed for the docker-init.sh script
COPY recipes $HOME/recipes
COPY scripts $HOME/scripts

CMD ["iex"]
