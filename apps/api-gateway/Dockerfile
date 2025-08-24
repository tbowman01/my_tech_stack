# Multi-stage build with Chainguard base images
FROM cgr.dev/chainguard/node:latest-dev as builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Production stage
FROM cgr.dev/chainguard/node:latest

WORKDIR /app

# Copy dependencies from builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy application source
COPY src ./src
COPY package.json ./

# Create non-root user directories
RUN mkdir -p /tmp && chmod 1777 /tmp

# Switch to non-root user
USER 65532:65532

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "fetch('http://localhost:8080/healthz').then(r => r.ok ? process.exit(0) : process.exit(1)).catch(() => process.exit(1))"

# Start application
CMD ["node", "src/index.js"]