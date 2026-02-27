# High-Performance L-4 TCP Load Balancer

A high-speed **Layer 4 Load Balancer** built in C++ that efficiently distributes TCP traffic across multiple backend servers using a non-blocking, event-driven architecture.

> 🚧 **Status: Active Development.** Currently building out core network routing.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| **C++17** | Core language with modern standard features |
| **POSIX Sockets** | Low-level TCP networking |
| **Epoll (Linux)** | Scalable, non-blocking I/O multiplexing |
| **Pthreads** | Multi-threaded worker pool execution |
| **Docker** | Containerized builds and deployment |

---

## Key Architecture

```
                          ┌──────────────────┐
    Incoming TCP ────────►│  L4 Load Balancer │
    Connections           │  (Epoll Event     │
                          │   Loop)           │
                          └────────┬─────────┘
                                   │
                    ┌──────────────┼──────────────┐
                    ▼              ▼              ▼
              ┌──────────┐  ┌──────────┐  ┌──────────┐
              │ Backend 1 │  │ Backend 2 │  │ Backend 3 │
              └──────────┘  └──────────┘  └──────────┘
```

The load balancer is designed around four core pillars:

- **Event-Driven Concurrency (Epoll)** — Uses Linux's `epoll` interface to monitor thousands of TCP connections simultaneously without creating a thread per connection.
- **Thread Pool Execution** — Delegates accepted connections to a configurable pool of worker threads, maximizing CPU utilization while avoiding thread-creation overhead.
- **Active Health Checking** — Periodically probes backend servers with TCP health checks, automatically removing unhealthy targets from the routing pool and re-adding them on recovery.
- **Round-Robin Routing** — Distributes incoming connections evenly across all healthy backends using a simple, fair round-robin scheduling algorithm.

---

## Development Roadmap

### Phase 1 — TCP Foundation `🔨 In Progress`

- [x] Project scaffolding (CMake, Docker, CI-ready structure)
- [ ] TCP listener socket with `bind()` / `listen()` / `accept()`
- [ ] Basic Round-Robin forwarding to a set of hardcoded backends
- [ ] Bi-directional data relay between client ↔ backend

### Phase 2 — Non-Blocking I/O `📋 Planned`

- [ ] Replace blocking sockets with non-blocking mode
- [ ] Integrate Linux `epoll` for scalable event multiplexing
- [ ] Implement edge-triggered notifications for high throughput
- [ ] Graceful connection teardown and cleanup

### Phase 3 — Concurrency & Reliability `📋 Planned`

- [ ] Worker thread pool with task queue
- [ ] Active TCP health checks on a configurable interval
- [ ] Automatic backend drain / re-addition on health state changes
- [ ] Per-connection timeout enforcement

---

## Project Structure

```
High-Performance-Load-Balancer/
├── CMakeLists.txt
├── Dockerfile
├── README.md
├── include/          # Public headers
├── src/
│   └── main.cpp      # Entry point
└── tests/            # Unit & integration tests
```

---

## Getting Started

### Prerequisites

- A C++17-compatible compiler (GCC 9+ or Clang 10+)
- CMake ≥ 3.16
- Linux (required for `epoll`)
- Docker (optional, for containerized builds)

### Build

```bash
mkdir build && cd build
cmake ..
make
```

### Run

```bash
./load_balancer
```

### Docker

```bash
docker build -t load-balancer .
docker run --rm --network host load-balancer
```

---

## License

This project is available under the [MIT License](LICENSE).
