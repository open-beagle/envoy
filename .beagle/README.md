# envoy

<https://github.com/envoyproxy/envoy>

```bash
# upstream
git remote add upstream git@github.com:envoyproxy/envoy.git

# fetch
git fetch upstream

# merge
git merge v1.23.12
```

## 注意

v1.24以上的版本要求Ubuntu 20.04 glibc >= 2.30.
大部分国产系统无法使用这么高的glibc.
所以使用v1.23进行安装迭代。

## Images

```bash
export SOCKS5_PROXY=socks5://www.ali.wodcloud.com:1283
export ENVOY_VERSION=1.23.12
rm -rf build
mkdir -p build 
curl -x ${SOCKS5_PROXY} -L https://github.com/envoyproxy/envoy/releases/download/v${ENVOY_VERSION}/envoy-${ENVOY_VERSION}-linux-x86_64 > build/envoy-linux-amd64
curl -x ${SOCKS5_PROXY} -L https://github.com/envoyproxy/envoy/releases/download/v${ENVOY_VERSION}/envoy-${ENVOY_VERSION}-linux-aarch_64 > build/envoy-linux-arm64
```

### amd64

```bash
# envoy
docker pull envoyproxy/envoy:v1.23.12 && \
docker tag envoyproxy/envoy:v1.23.12 registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-amd64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-amd64
```

### arm64

```bash
# envoy
docker pull --platform=linux/arm64 envoyproxy/envoy:v1.23.12 && \
docker tag envoyproxy/envoy:v1.23.12 registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-arm64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-arm64
```

### mips64le

```bash
# envoy
docker pull loongnixk8s/envoyproxy-envoy:v1.15.1 && \
docker tag loongnixk8s/envoyproxy-envoy:v1.15.1 registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-mips64le && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-mips64le
```

### arch

```bash
# envoy
docker run --rm \
  -e PLUGIN_PLATFORMS=linux/amd64,linux/arm64,linux/mips64le \
  -e PLUGIN_TEMPLATE=registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11-ARCH \
  -e PLUGIN_TARGET=registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.11 \
  -e PLUGIN_USERNAME=$PLUGIN_REGISTRY_USER \
  -e PLUGIN_PASSWORD=$PLUGIN_REGISTRY_PASSWORD \
  -v /var/run/docker.sock:/var/run/docker.sock \
  registry.cn-qingdao.aliyuncs.com/wod/devops-docker-manifest:1.0
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

docker run -it --rm \
  -v $PWD/:/go/src/github.com/envoyproxy/envoy \
  -w /go/src/github.com/envoyproxy/envoy \
  registry-vpc.cn-qingdao.aliyuncs.com/wod/golang:v1.22.2-bullseye-amd64 \
  bash
  export PATH="/usr/lib/llvm-11/bin:$PATH" && \
  export LDFLAGS="-L /usr/lib/llvm-11/lib" && \
  export CPPFLAGS="-I /usr/lib/llvm-11/include" && \
  export GOPROXY=https://goproxy.cn && \
  bazel build -c opt --config=clang envoy
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
