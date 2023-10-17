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
