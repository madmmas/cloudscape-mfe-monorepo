# Makefile Quick Reference

## 🚀 Quick Start Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make quick-start` | Install, build, and start production environment |
| `make quick-start-dev` | Install and start development servers |
| `make dev-workflow` | Complete development workflow (install → build → dev) |
| `make prod-workflow` | Complete production workflow (install → build → docker) |

## 🛠️ Development Commands

| Command | Description |
|---------|-------------|
| `make install` | Install all dependencies |
| `make dev` | Start all development servers |
| `make dev-host` | Start only host development server |
| `make dev-dashboard` | Start only dashboard development server |
| `make dev-orders` | Start only orders development server |

## 🐳 Docker Commands

| Command | Description |
|---------|-------------|
| `make docker-prod` | Start production Docker environment |
| `make docker-dev` | Start development Docker environment |
| `make docker-build` | Build all Docker containers |
| `make docker-stop` | Stop all Docker containers |
| `make docker-logs` | Show Docker container logs |
| `make docker-clean` | Clean up Docker resources |

## 🔨 Build Commands

| Command | Description |
|---------|-------------|
| `make build` | Build all packages |
| `make build-host` | Build only host package |
| `make build-dashboard` | Build only dashboard package |
| `make build-orders` | Build only orders package |

## 🧪 Testing & Quality

| Command | Description |
|---------|-------------|
| `make test` | Run all tests |
| `make lint` | Run linting on all packages |
| `make lint-fix` | Fix linting issues automatically |

## 📊 Monitoring & Status

| Command | Description |
|---------|-------------|
| `make status` | Show current status of services |
| `make health-check` | Check health of all services |
| `make check-ports` | Check if required ports are available |
| `make logs` | Show all logs |

## 🧹 Cleanup Commands

| Command | Description |
|---------|-------------|
| `make clean` | Clean build artifacts |
| `make clean-all` | Clean build artifacts and node_modules |
| `make docker-clean` | Clean up Docker containers, images, and volumes |

## 🚀 Deployment Commands

| Command | Description |
|---------|-------------|
| `make deploy` | Full production deployment |
| `make deploy-dev` | Full development deployment |

## 📋 Common Workflows

### Development Workflow
```bash
make install          # Install dependencies
make dev              # Start development servers
# ... develop ...
make build            # Build for testing
make test             # Run tests
```

### Production Workflow
```bash
make install          # Install dependencies
make build            # Build all packages
make docker-build     # Build Docker containers
make docker-prod      # Start production environment
```

### Quick Development Start
```bash
make quick-start-dev  # One command to get started
```

### Quick Production Start
```bash
make quick-start      # One command for production
```

## 🎯 Service URLs

After starting the services:

- **Host App**: http://localhost:3000
- **Dashboard MFE**: http://localhost:3001
- **Orders MFE**: http://localhost:3002

## 🔧 Troubleshooting

### Check Service Status
```bash
make status           # Show running containers and port usage
make health-check     # Verify all services are responding
make check-ports      # Check if ports are available
```

### View Logs
```bash
make docker-logs      # Show Docker container logs
make logs             # Show all logs
```

### Clean and Restart
```bash
make docker-stop      # Stop containers
make docker-clean     # Clean Docker resources
make docker-prod      # Restart production environment
```

## 💡 Tips

1. **Use `make help`** to see all available commands
2. **Use `make quick-start-dev`** for fast development setup
3. **Use `make status`** to check if services are running
4. **Use `make health-check`** to verify all services are healthy
5. **Use `make docker-clean`** if you encounter Docker issues 