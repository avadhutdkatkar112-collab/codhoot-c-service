FROM golang:1.22-bookworm AS builder
WORKDIR /app
COPY go.mod .
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o codhoot-c-service .

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libc6-dev make ca-certificates \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/codhoot-c-service .
ENV PORT=8081
EXPOSE 8081
CMD ["./codhoot-c-service"]
