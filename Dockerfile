# ── Build stage ─────────────────────────────────────────────────────────────────
FROM gcc:13 AS builder

WORKDIR /app

COPY CMakeLists.txt .
COPY src/ src/
COPY include/ include/

RUN mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j$(nproc)

# ── Runtime stage ──────────────────────────────────────────────────────────────
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/build/load_balancer /usr/local/bin/load_balancer

EXPOSE 8080

ENTRYPOINT ["load_balancer"]
