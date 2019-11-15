FROM debian:10

ARG VNAME

# Install dependencies
RUN apt-get update && apt-get install -y make python-docutils python-cram zsh

# Copy sources

COPY _build/pkg/debian/$VNAME-0_all.deb /
COPY _build/sdist/$VNAME.tar.gz /

RUN tar xf /$VNAME.tar.gz && mv $VNAME src

RUN dpkg -i /$VNAME-0_all.deb

# Run check
WORKDIR /src
CMD make sys-check
