# Multi-stage build with Chainguard Python
FROM cgr.dev/chainguard/python:latest-dev as builder

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM cgr.dev/chainguard/python:latest

WORKDIR /app

# Copy dependencies from builder
COPY --from=builder /home/nonroot/.local/lib/python3.11/site-packages /home/nonroot/.local/lib/python3.11/site-packages

# Copy application code
COPY main.py .

# Set Python path
ENV PYTHONPATH=/home/nonroot/.local/lib/python3.11/site-packages

# Switch to non-root user
USER 65532:65532

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:8080/healthz').raise_for_status()" || exit 1

# Start application
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]