# Docker Setup for Cloudscape MFE Monorepo

This repository includes Docker configurations for both development and production environments.

## 🐳 Production Setup

### Build and Run Production Containers

```bash
# Build and start all services
docker-compose up --build

# Run in detached mode
docker-compose up --build -d

# Stop all services
docker-compose down
```

### Production Services

- **Host App**: http://localhost:3000
- **Dashboard MFE**: http://localhost:3001
- **Orders MFE**: http://localhost:3002

### Production Architecture

- Uses multi-stage builds for optimized production images
- Nginx serves static files with proper CORS headers
- Micro frontends are built and served as static assets
- Host application loads remote entries from containerized micro frontends

## 🛠️ Development Setup

### Build and Run Development Containers

```bash
# Build and start development services
docker-compose -f docker-compose.dev.yml up --build

# Run in detached mode
docker-compose -f docker-compose.dev.yml up --build -d

# Stop development services
docker-compose -f docker-compose.dev.yml down
```

### Development Features

- Hot reloading with volume mounts
- Vite dev servers for each application
- Shared node_modules for faster builds
- Development-specific configurations

## 📁 Docker Files Structure

```
├── docker-compose.yml              # Production orchestration
├── docker-compose.dev.yml          # Development orchestration
├── .dockerignore                   # Docker build exclusions
├── host/
│   ├── Dockerfile                  # Production host build
│   ├── Dockerfile.dev              # Development host
│   ├── nginx.conf                  # Production nginx config
│   └── vite.config.prod.ts         # Production Vite config
├── mfe-dashboard/
│   ├── Dockerfile                  # Production dashboard build
│   ├── Dockerfile.dev              # Development dashboard
│   └── nginx.conf                  # Production nginx config
├── mfe-orders/
│   ├── Dockerfile                  # Production orders build
│   ├── Dockerfile.dev              # Development orders
│   └── nginx.conf                  # Production nginx config
```

## 🔧 Configuration Details

### Production Build Process

1. **Multi-stage builds** reduce final image size
2. **Nginx** serves optimized static files
3. **CORS headers** enable micro frontend federation
4. **Security headers** protect against common vulnerabilities
5. **Gzip compression** improves performance

### Development Features

1. **Volume mounts** enable hot reloading
2. **Shared dependencies** across containers
3. **Development servers** with live reload
4. **Network isolation** between services

## 🚀 Quick Start Commands

### Production
```bash
# Start production environment
docker-compose up --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Development
```bash
# Start development environment
docker-compose -f docker-compose.dev.yml up --build

# View logs
docker-compose -f docker-compose.dev.yml logs -f

# Stop services
docker-compose -f docker-compose.dev.yml down
```

## 🔍 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 3000, 3001, 3002 are available
2. **Build failures**: Check that all dependencies are properly installed
3. **CORS errors**: Verify nginx configurations include proper CORS headers
4. **Network issues**: Ensure Docker network is properly configured

### Debug Commands

```bash
# Check container status
docker-compose ps

# View container logs
docker-compose logs [service-name]

# Access container shell
docker-compose exec [service-name] sh

# Rebuild specific service
docker-compose build [service-name]
```

## 📊 Performance Optimizations

- **Multi-stage builds** reduce image size by ~70%
- **Nginx caching** improves static asset delivery
- **Gzip compression** reduces bandwidth usage
- **Security headers** protect against vulnerabilities
- **Optimized nginx config** for micro frontend serving

## 🔒 Security Features

- **CORS headers** properly configured for federation
- **Security headers** (X-Frame-Options, X-XSS-Protection, etc.)
- **Content Security Policy** for XSS protection
- **No sensitive data** in Docker images
- **Minimal attack surface** with Alpine Linux base images 