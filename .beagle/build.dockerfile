ARG BASE

FROM $BASE

LABEL maintainer=$AUTHOR version=$VERSION

RUN sed -i 's/http\:\/\/deb.debian.org/http\:\/\/repo.huaweicloud.com/g' /etc/apt/sources.list && \
    sed -i 's/http\:\/\/security.debian.org/http\:\/\/repo.huaweicloud.com/g' /etc/apt/sources.list && \
    sed -i 's/http\:\/\/snapshot.debian.org/http\:\/\/repo.huaweicloud.com/g' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && apt install apt-transport-https ca-certificates -y && \
    sed -i 's/http\:\/\/repo.huaweicloud.com/https\:\/\/repo.huaweicloud.com/g' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y --no-install-recommends \
      autoconf \
      automake \
      cmake \
      curl \
      libtool \
      make \
      ninja-build \
      patch \
      python3-pip \
      unzip \
      virtualenv \
      clang \
      llvm \
      libc++-11-dev \
      libstdc++-10-dev \
      git \
    && apt-get clean \
    && rm -rf /var/cache/apt /var/lib/apt/lists/* /etc/apt/sources.list.d/*.list \
    && curl -x socks5://www.ali.wodcloud.com:1283 \
    -sL https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-$([ $(uname -m) = "aarch64" ] && echo "arm64" || echo "amd64") > \
    /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel \

