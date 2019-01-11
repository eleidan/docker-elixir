FROM eleidan/elixir:1.7.3-ubuntu-16.04

USER root

### Adopt container user for the host UID and GID
ARG HOST_UID=1000
ARG HOST_GID=1000
RUN usermod -u ${HOST_UID} phantom
RUN groupmod -g ${HOST_GID} phantom
RUN chown phantom:phantom ${HOME}

RUN apt-get update && apt-get install -y --no-install-recommends \
      locales \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US

RUN echo $LANG UTF-8 > /etc/locale.gen \
    && locale-gen \
    && update-locale

USER phantom
