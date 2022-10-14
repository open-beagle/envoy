# envoy

<https://github.com/envoyproxy/envoy>

```bash
# upstream
git remote add upstream git@github.com:envoyproxy/envoy.git

# fetch
git fetch upstream

# merge
git merge v1.23.1
```

## Images

### amd64

```bash
# envoy
docker pull envoyproxy/envoy:v1.23.1 && \
docker tag envoyproxy/envoy:v1.23.1 registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1-amd64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1-amd64
```

### arm64

```bash
# envoy
docker pull --platform=linux/arm64 envoyproxy/envoy:v1.23.1 && \
docker tag envoyproxy/envoy:v1.23.1 registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1-arm64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1-arm64
```

### arch

```bash
# envoy
docker run --rm \
  -e PLUGIN_PLATFORMS=linux/amd64,linux/arm64 \
  -e PLUGIN_TEMPLATE=registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1-ARCH \
  -e PLUGIN_TARGET=registry.cn-qingdao.aliyuncs.com/wod/envoy:1.23.1 \
  -e PLUGIN_USERNAME=$PLUGIN_REGISTRY_USER \
  -e PLUGIN_PASSWORD=$PLUGIN_REGISTRY_PASSWORD \
  -v /var/run/docker.sock:/var/run/docker.sock \
  registry.cn-qingdao.aliyuncs.com/wod/devops-docker-manifest:1.0
```
