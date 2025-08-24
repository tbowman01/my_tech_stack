#!/bin/bash
set -e

# Create multiple databases for different services
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Create databases for different services
    CREATE DATABASE users;
    CREATE DATABASE analytics;
    CREATE DATABASE keycloak;
    
    -- Create users with specific permissions
    CREATE USER users_service WITH PASSWORD 'users_service_password';
    CREATE USER analytics_service WITH PASSWORD 'analytics_service_password';
    CREATE USER keycloak_user WITH PASSWORD 'keycloak_password';
    
    -- Grant permissions
    GRANT ALL PRIVILEGES ON DATABASE users TO users_service;
    GRANT ALL PRIVILEGES ON DATABASE analytics TO analytics_service;
    GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak_user;
    
    -- Connect to users database and create initial schema
    \\c users;
    
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    
    CREATE TABLE IF NOT EXISTS users (
        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        status VARCHAR(50) DEFAULT 'active',
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        metadata JSONB DEFAULT '{}'::jsonb
    );
    
    CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
    CREATE INDEX IF NOT EXISTS idx_users_status ON users(status);
    CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);
    
    -- Insert sample data
    INSERT INTO users (name, email, metadata) VALUES 
        ('Alice Johnson', 'alice@example.com', '{"role": "admin", "department": "engineering"}'),
        ('Bob Smith', 'bob@example.com', '{"role": "user", "department": "product"}'),
        ('Carol Davis', 'carol@example.com', '{"role": "user", "department": "design"}')
    ON CONFLICT (email) DO NOTHING;
    
    -- Connect to analytics database and create schema
    \\c analytics;
    
    CREATE TABLE IF NOT EXISTS events (
        id BIGSERIAL PRIMARY KEY,
        event_type VARCHAR(100) NOT NULL,
        user_id UUID,
        session_id VARCHAR(255),
        timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        properties JSONB DEFAULT '{}'::jsonb,
        metadata JSONB DEFAULT '{}'::jsonb
    );
    
    CREATE INDEX IF NOT EXISTS idx_events_timestamp ON events(timestamp);
    CREATE INDEX IF NOT EXISTS idx_events_type ON events(event_type);
    CREATE INDEX IF NOT EXISTS idx_events_user_id ON events(user_id);
    
    -- Insert sample analytics data
    INSERT INTO events (event_type, user_id, properties) VALUES 
        ('user_login', (SELECT id FROM users.users WHERE email = 'alice@example.com'), '{"ip": "192.168.1.100", "user_agent": "Chrome/120.0"}'),
        ('api_request', (SELECT id FROM users.users WHERE email = 'bob@example.com'), '{"endpoint": "/api/users", "method": "GET", "response_time_ms": 45}'),
        ('ai_inference', (SELECT id FROM users.users WHERE email = 'carol@example.com'), '{"model": "gpt-3.5-turbo", "tokens": 150, "latency_ms": 1200}')
    ON CONFLICT DO NOTHING;
    
    EOSQL

echo "PostgreSQL initialization completed successfully!"
echo "Created databases: users, analytics, keycloak"
echo "Created sample data for development"