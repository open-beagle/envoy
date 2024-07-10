# envoy

<https://github.com/envoyproxy/envoy>

```bash
# upstream
git remote add upstream git@github.com:envoyproxy/envoy.git

# fetch
git fetch upstream

# merge
git merge v1.30.4
```

## bin

```bash
mkdir -p build && \
  curl -x socks5://www.ali.wodcloud.com:1283 -sL \
  https://github.com/envoyproxy/envoy/releases/download/v1.30.4/envoy-1.30.4-linux-x86_64 > \
  build/envoy-1.30.4-linux-x86_64
```

## build

```bash
docker build \
  --no-cache \
  --file ./.beagle/build.dockerfile \
  --build-arg BASE=registry-vpc.cn-qingdao.aliyuncs.com/wod/debian:bullseye \
  --tag registry-vpc.cn-qingdao.aliyuncs.com/wod/envoy:1.23-build \
  .

docker push registry-vpc.cn-qingdao.aliyuncs.com/wod/envoy:1.23-build

mkdir -p build && \
  curl -x socks5://www.ali.wodcloud.com:1283 -sL \
    https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz > \
    build/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz  &&  \
  tar -xf build/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz -C build

docker run -it --rm \
  -v $PWD/:/go/src/github.com/envoyproxy/envoy \
  -w /go/src/github.com/envoyproxy/envoy \
  registry-vpc.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-202405-amd64 \
  bash

  13467 / 14820

  groupadd -r docker && \
  useradd -r -g docker docker && \
  su docker && \
  export HTTPS_PROXY=http://www.ali.wodcloud.com:1284 && \
  export HTTP_PROXY=http://www.ali.wodcloud.com:1284 && \
  export GOPROXY=https://goproxy.cn && \
  bazel build -c opt envoy

  sudo apt install -y libc++-14-dev libstdc++-11-dev

docker pull envoyproxy/envoy-build-ubuntu:75238004b0fcfd8a7f71d380d7a774dda5c39622 && \
docker tag envoyproxy/envoy-build-ubuntu:75238004b0fcfd8a7f71d380d7a774dda5c39622 registry.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-20240521-amd64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-20240521-amd64

export LLVM_ROOT=/home/code/go/src/github.com/open-beagle/envoy/build/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04
./ci/do_ci.sh dev

mc cp --recursive ./linux/amd64/build_envoy_fastbuild_stripped/envoy-v1.30.5-linux-x86_64 cache/kubernetes/k8s/envoy/envoy-v1.30.5-linux-amd64

docker build \
  --build-arg BASE=registry.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-20240521-amd64 \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=20240521 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=amd64 \
  --tag registry-vpc.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-202405-amd64 \
  --file .beagle/build.dockerfile .

docker push registry-vpc.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-202405-amd64

docker pull registry.cn-qingdao.aliyuncs.com/wod/envoy:build-ubuntu-20240521-amd64
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="envoy" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="envoy" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
