FROM golang:alpine@sha256:86d32cc0dfc04757fd8aeebb86308e6d1e3de60c73cb59e0f99c7b2ef77416b6 AS builder

RUN apk --no-cache add make
COPY . /app
RUN make -C /app/grpc-service

FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978

COPY --from=builder /app/grpc-service/server /app/server
CMD ["/app/server", "-users", "/etc/users.json"]
