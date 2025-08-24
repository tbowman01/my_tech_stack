# Multi-stage build with Chainguard images
FROM cgr.dev/chainguard/rust:latest-dev as builder

WORKDIR /work

# Copy manifests
COPY Cargo.toml Cargo.lock ./

# Create dummy main to cache dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build dependencies (this will be cached)
RUN cargo build --release && rm -rf src target/release/deps/users*

# Copy source code
COPY src ./src

# Build for release
RUN cargo build --release

# Runtime stage with distroless
FROM gcr.io/distroless/cc-debian12:latest

# Copy the binary from builder stage
COPY --from=builder /work/target/release/users /usr/local/bin/users

# Set the user to non-root
USER 65532:65532

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["/usr/local/bin/users", "--health-check"] || exit 1

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/users"]