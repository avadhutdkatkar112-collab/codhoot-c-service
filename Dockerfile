FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY codhoot-c-service .

ENV PORT=8081
EXPOSE 8081

CMD ["./codhoot-c-service"]
