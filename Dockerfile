FROM ubuntu:xenial

ENV DEBIAN_FRONTENTD=noninteractive \
    APT_INSTALL_OPTIONS="-y -q0 --no-install-recommends" \ 
    CONFIG_URL="https://pastebin.com/raw/fauk6xyY" \
    GIT_URL=https://github.com/eliasmagn/bpir2wrt.git \
    GIT_BRANCH="master" \
    MAKE_WORKERS=7 \
#    MAKE_WORKERS=1 \
    FORCE_UNSAFE_CONFIGURE=1 \
    LANG=C

RUN   apt-get update && apt-get ${APT_INSTALL_OPTIONS} install \
      git \
      build-essential \
      flex \
      python \
      unzip \
      gawk \
      subversion \
      libz3-dev \
      time \
      file \
      wget \
      curl \
      libncurses5-dev \
      ca-certificates

RUN git clone ${GIT_URL} /opt && cd /opt && git checkout ${GIT_BRANCH}
WORKDIR /opt
RUN ./scripts/feeds update -a && ./scripts/feeds install -a
RUN wget ${CONFIG_URL} -O .config
RUN make oldconfig
RUN make -j${MAKE_WORKERS}