FROM golang:1.18-bullseye@sha256:d146bc2ee9b0691f4f787bd9a8bf12e3c01a4618ea982d11fe9401b86211e2a7 as builder

WORKDIR /build

# Resolve and build Go dependencies as Docker cache
COPY go.mod /build/go.mod
COPY go.sum /build/go.sum
COPY kv/go.mod /build/kv/go.mod

ENV GO111MODULE=on
RUN go mod download

COPY service.go /build/main.go
COPY kv/ /build/kv

# Build for linux
ENV GOOS=linux
ENV GOARCH=amd64
ENV CGO_ENABLED=0
RUN go build -o server

# Build the main container (Linux Runtime)
FROM debian:bullseye-slim@sha256:8eaee63a5ea83744e62d5bf88e7d472d7f19b5feda3bfc6a2304cc074f269269
WORKDIR /root/

# Copy the linux amd64 binary
COPY --from=builder /build/server /bin/

ENTRYPOINT /bin/server
