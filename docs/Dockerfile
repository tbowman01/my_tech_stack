# Dockerfile for Docusaurus documentation
FROM cgr.dev/chainguard/node:latest-dev as builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source
COPY . .

# Build documentation
RUN npm run build

# Production stage
FROM cgr.dev/chainguard/node:latest

WORKDIR /app

# Copy built documentation
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Switch to non-root user
USER 65532:65532

# Expose port
EXPOSE 3000

# Start documentation server
CMD ["npm", "run", "serve"]