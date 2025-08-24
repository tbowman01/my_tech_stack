#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REGISTRY="${REGISTRY:-ghcr.io}"
ORG="${ORG:-$(git config --get remote.origin.url | sed 's/.*[:/]\([^/]*\/[^/]*\)\.git/\1/' || echo 'your-org/enterprise-ai-platform')}"
TAG="${TAG:-$(git rev-parse --short HEAD)}"
PLATFORM="${PLATFORM:-linux/amd64,linux/arm64}"

echo -e "${GREEN}Building all container images...${NC}"
echo -e "Registry: ${REGISTRY}/${ORG}"
echo -e "Tag: ${TAG}"
echo -e "Platform: ${PLATFORM}"
echo ""

# Function to build and push image
build_and_push() {
    local service_path=$1
    local image_name=$2
    local dockerfile_path=${3:-Dockerfile}
    
    if [[ ! -d "$service_path" ]]; then
        echo -e "${YELLOW}Warning: $service_path not found, skipping...${NC}"
        return 0
    fi
    
    if [[ ! -f "$service_path/$dockerfile_path" ]]; then
        echo -e "${YELLOW}Warning: $service_path/$dockerfile_path not found, skipping...${NC}"
        return 0
    fi
    
    echo -e "${GREEN}Building $image_name...${NC}"
    
    # Build and push multi-platform image
    docker buildx build \
        --platform "$PLATFORM" \
        --tag "${REGISTRY}/${ORG}/${image_name}:${TAG}" \
        --tag "${REGISTRY}/${ORG}/${image_name}:latest" \
        --push \
        --file "$service_path/$dockerfile_path" \
        "$service_path"
    
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✓ Successfully built and pushed $image_name${NC}"
    else
        echo -e "${RED}✗ Failed to build $image_name${NC}"
        return 1
    fi
}

# Ensure docker buildx is available
if ! docker buildx version > /dev/null 2>&1; then
    echo -e "${RED}Error: docker buildx is required but not available${NC}"
    exit 1
fi

# Create buildx builder if not exists
if ! docker buildx ls | grep -q "enterprise-ai-builder"; then
    echo -e "${YELLOW}Creating buildx builder...${NC}"
    docker buildx create --name enterprise-ai-builder --platform "$PLATFORM" --use
fi

# Use the builder
docker buildx use enterprise-ai-builder

# Build all services
echo -e "${GREEN}Building application services...${NC}"

# API Gateway (Node.js)
build_and_push "apps/api-gateway" "api-gateway"

# Users Service (Rust) 
build_and_push "services/users" "users"

# AI Inference Service (Python)
build_and_push "apps/ai/inference" "ai-inference"

# Stream Ingest Service (Rust) - if it exists
build_and_push "apps/stream-ingest" "stream-ingest"

# Web Application (Next.js) - if it exists
build_and_push "apps/web" "web"

# Workers (Node.js/Python) - if they exist
build_and_push "apps/workers" "workers"

# Analytics Service (if it exists)
build_and_push "services/analytics" "analytics"

echo ""
echo -e "${GREEN}All images built and pushed successfully!${NC}"
echo ""
echo "Images:"
echo "  ${REGISTRY}/${ORG}/api-gateway:${TAG}"
echo "  ${REGISTRY}/${ORG}/users:${TAG}"
echo "  ${REGISTRY}/${ORG}/ai-inference:${TAG}"
echo ""
echo "To deploy these images, run:"
echo "  make deploy-dev"