FROM golang:1.21 as development

LABEL maintainer="Miguel Gutierrez <gt2rz.dev@gmail.com>"
LABEL version="1.0"
LABEL description="Dockerfile for development"

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

EXPOSE 8080

RUN go install github.com/cosmtrek/air@latest && \
    go install -v golang.org/x/tools/gopls@latest && \
    go mod download && \
    go mod verify && \
    go mod tidy

CMD ["air", "-c", ".air.toml"]
