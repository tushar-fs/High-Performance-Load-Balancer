cmake_minimum_required(VERSION 3.16)
project(load_balancer
    VERSION 0.1.0
    DESCRIPTION "High-Performance L-4 TCP Load Balancer"
    LANGUAGES CXX
)

# ── C++17 Standard ──────────────────────────────────────────────────────────────
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ── Compiler warnings ──────────────────────────────────────────────────────────
add_compile_options(-Wall -Wextra -Wpedantic)

# ── Include directories ────────────────────────────────────────────────────────
include_directories(${PROJECT_SOURCE_DIR}/include)

# ── Source files ───────────────────────────────────────────────────────────────
file(GLOB_RECURSE SOURCES "src/*.cpp")

# ── Executable ─────────────────────────────────────────────────────────────────
add_executable(${PROJECT_NAME} ${SOURCES})

# ── Link libraries ────────────────────────────────────────────────────────────
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
