import Fastify from 'fastify';
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-grpc';

// Initialize OpenTelemetry before importing other modules
const sdk = new NodeSDK({
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://otel-collector:4317',
  }),
  instrumentations: [getNodeAutoInstrumentations()],
  serviceName: process.env.OTEL_SERVICE_NAME || 'api-gateway',
  serviceVersion: process.env.OTEL_SERVICE_VERSION || '0.1.0',
});

sdk.start();

const app = Fastify({ 
  logger: {
    level: process.env.LOG_LEVEL || 'info',
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true,
        translateTime: 'HH:MM:ss Z',
        ignore: 'pid,hostname',
      },
    },
  }
});

// Register plugins
await app.register(import('@fastify/helmet'), {
  contentSecurityPolicy: false,
});

await app.register(import('@fastify/cors'), {
  origin: true,
});

await app.register(import('@fastify/rate-limit'), {
  max: 100,
  timeWindow: '1 minute',
});

await app.register(import('@fastify/under-pressure'), {
  maxEventLoopDelay: 1000,
  maxHeapUsedBytes: 100000000,
  maxRssBytes: 100000000,
  maxEventLoopUtilization: 0.98,
});

// Health check endpoint
app.get('/healthz', async (request, reply) => {
  return { 
    status: 'ok', 
    timestamp: new Date().toISOString(),
    service: 'api-gateway',
    version: process.env.OTEL_SERVICE_VERSION || '0.1.0'
  };
});

// Readiness check endpoint
app.get('/readyz', async (request, reply) => {
  return { 
    status: 'ready',
    timestamp: new Date().toISOString()
  };
});

// Metrics endpoint for Prometheus
app.get('/metrics', async (request, reply) => {
  reply.type('text/plain');
  return '# TODO: Implement Prometheus metrics';
});

// Main API endpoint
app.get('/', async (request, reply) => {
  return { 
    service: 'api-gateway',
    version: process.env.OTEL_SERVICE_VERSION || '0.1.0',
    environment: process.env.NODE_ENV || 'development',
    message: 'Enterprise AI Platform API Gateway'
  };
});

// Users service proxy (example)
app.get('/api/users/*', async (request, reply) => {
  // In a real implementation, this would proxy to the users service
  return {
    message: 'Proxying to users service',
    path: request.url,
    method: request.method
  };
});

// AI service proxy (example)
app.post('/api/ai/infer', async (request, reply) => {
  // In a real implementation, this would proxy to the AI inference service
  return {
    message: 'Proxying to AI inference service',
    payload: request.body
  };
});

// Error handling
app.setErrorHandler((error, request, reply) => {
  request.log.error(error);
  
  if (error.statusCode >= 500) {
    reply.status(500).send({
      error: 'Internal Server Error',
      statusCode: 500,
      timestamp: new Date().toISOString()
    });
  } else {
    reply.send(error);
  }
});

// Start server
const start = async () => {
  try {
    const port = process.env.PORT || 8080;
    const host = process.env.HOST || '0.0.0.0';
    
    await app.listen({ port, host });
    app.log.info(`API Gateway listening on ${host}:${port}`);
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
};

// Graceful shutdown
process.on('SIGINT', async () => {
  app.log.info('Received SIGINT, shutting down gracefully');
  await app.close();
  await sdk.shutdown();
  process.exit(0);
});

process.on('SIGTERM', async () => {
  app.log.info('Received SIGTERM, shutting down gracefully');
  await app.close();
  await sdk.shutdown();
  process.exit(0);
});

start();