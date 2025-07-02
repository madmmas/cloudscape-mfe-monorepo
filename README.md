# 🏗️ Cloudscape Micro Frontend Monorepo

A modern micro frontend architecture built with React 18, TypeScript, Vite, and AWS Cloudscape Design System. This monorepo demonstrates a scalable approach to building large-scale web applications using micro frontends.

## 📋 Table of Contents

- [🏗️ Architecture Overview](#️-architecture-overview)
- [🚀 Quick Start](#-quick-start)
- [📦 Project Structure](#-project-structure)
- [🛠️ Development](#️-development)
- [🐳 Docker](#-docker)
- [📚 Available Scripts](#-available-scripts)
- [🔧 Configuration](#-configuration)
- [🧪 Testing](#-testing)
- [📦 Build & Deployment](#-build--deployment)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

## 🏗️ Architecture Overview

This project implements a **Module Federation** pattern using Vite's federation plugin, allowing independent micro frontends to be developed, built, and deployed separately while being composed together at runtime.

### **Core Components**

- **Host Application** (`host/`) - The main shell application that orchestrates micro frontends
- **Dashboard MFE** (`mfe-dashboard/`) - Dashboard micro frontend with analytics and metrics
- **Orders MFE** (`mfe-orders/`) - Orders management micro frontend

### **Technology Stack**

- **Frontend Framework**: React 18 with TypeScript
- **Build Tool**: Vite with Module Federation
- **Package Manager**: pnpm with workspaces
- **UI Framework**: AWS Cloudscape Design System
- **Routing**: React Router v6
- **Monorepo Tool**: Turbo
- **Containerization**: Docker & Docker Compose

## 🚀 Quick Start

### **Prerequisites**

- Node.js 18+ 
- pnpm 8+
- Docker & Docker Compose (for containerized development)

### **Installation**

```bash
# Clone the repository
git clone <repository-url>
cd cloudscape-mfe-monorepo

# Install dependencies
make install

# Start development servers
make dev
```

### **Access the Application**

- **Host App**: http://localhost:3000
- **Dashboard MFE**: http://localhost:3001
- **Orders MFE**: http://localhost:3002

## 📦 Project Structure

```
cloudscape-mfe-monorepo/
├── host/                    # Main shell application
│   ├── src/
│   │   ├── main.tsx        # Application entry point
│   │   ├── Navigation.tsx  # Side navigation component
│   │   └── Header.tsx      # Top navigation header
│   ├── package.json
│   ├── vite.config.ts
│   └── Dockerfile
├── mfe-dashboard/          # Dashboard micro frontend
│   ├── src/
│   │   ├── main.tsx        # MFE entry point
│   │   └── RemoteDashboard.tsx
│   ├── package.json
│   ├── vite.config.ts
│   └── Dockerfile
├── mfe-orders/             # Orders micro frontend
│   ├── src/
│   │   ├── main.tsx        # MFE entry point
│   │   └── RemoteOrders.tsx
│   ├── package.json
│   ├── vite.config.ts
│   └── Dockerfile
├── scripts/                # Build and deployment scripts
├── package.json            # Root package.json
├── pnpm-workspace.yaml     # pnpm workspace configuration
├── turbo.json             # Turbo configuration
├── docker-compose.yml     # Production Docker setup
├── docker-compose.dev.yml # Development Docker setup
├── Makefile               # Build automation
└── README.md
```

## 🛠️ Development

### **Development Workflow**

1. **Start Development Servers**
   ```bash
   make dev
   ```
   This starts all applications in parallel:
   - Host app on port 3000
   - Dashboard MFE on port 3001  
   - Orders MFE on port 3002

2. **Development Mode Features**
   - Hot Module Replacement (HMR)
   - Module Federation in development
   - Shared dependencies between MFEs
   - Real-time updates across all applications

### **Adding New Micro Frontends**

1. **Create New MFE Package**
   ```bash
   mkdir mfe-new-feature
   cd mfe-new-feature
   ```

2. **Initialize Package**
   ```bash
   pnpm init
   ```

3. **Configure Vite Federation**
   ```typescript
   // vite.config.ts
   import { defineConfig } from 'vite';
   import react from '@vitejs/plugin-react';
   import federation from '@originjs/vite-plugin-federation';

   export default defineConfig({
     plugins: [
       react(),
       federation({
         name: 'new-feature',
         filename: 'remoteEntry.js',
         exposes: {
           './RemoteNewFeature': './src/RemoteNewFeature.tsx',
         },
         shared: ['react', 'react-dom'],
       }),
     ],
     build: {
       target: 'esnext',
       modulePreload: false,
     },
   });
   ```

4. **Add to Host Application**
   ```typescript
   // host/src/main.tsx
   const NewFeature = React.lazy(() => import('new-feature/RemoteNewFeature'));
   
   // Add route
   <Route path="/new-feature" element={<NewFeature />} />
   ```

5. **Update Navigation**
   ```typescript
   // host/src/Navigation.tsx
   const navigationItems = [
     // ... existing items
     {
       type: 'link' as const,
       text: 'New Feature',
       href: '/new-feature',
     },
   ];
   ```

## 🐳 Docker

### **Development with Docker**

```bash
# Build and start development containers
make docker-dev

# View logs
make docker-logs

# Stop development containers
make docker-stop
```

### **Production with Docker**

```bash
# Build production images
make docker-build

# Start production containers
make docker-prod

# Scale services
make docker-scale
```

### **Docker Architecture**

- **Multi-stage builds** for optimized production images
- **Nginx** for serving static assets with CORS support
- **Health checks** for container monitoring
- **Environment-specific configurations**

## 📚 Available Scripts

### **Development Commands**

```bash
make install          # Install all dependencies
make dev              # Start all development servers
make dev-host         # Start only host application
make dev-dashboard    # Start only dashboard MFE
make dev-orders       # Start only orders MFE
```

### **Build Commands**

```bash
make build            # Build all applications
make build-host       # Build host application
make build-dashboard  # Build dashboard MFE
make build-orders     # Build orders MFE
```

### **Docker Commands**

```bash
make docker-build     # Build all Docker images
make docker-dev       # Start development containers
make docker-prod      # Start production containers
make docker-clean     # Clean Docker resources
```

### **Utility Commands**

```bash
make clean            # Clean build artifacts
make clean-all        # Clean everything including node_modules
make lint             # Run linting
make test             # Run tests
make format           # Format code
```

## 🔧 Configuration

### **Module Federation Configuration**

Each micro frontend exposes its components through Module Federation:

```typescript
// mfe-dashboard/vite.config.ts
federation({
  name: 'dashboard',
  filename: 'remoteEntry.js',
  exposes: {
    './RemoteDashboard': './src/RemoteDashboard.tsx',
  },
  shared: ['react', 'react-dom', '@cloudscape-design/components'],
})
```

### **Host Application Configuration**

The host application consumes remote modules:

```typescript
// host/vite.config.ts
federation({
  name: 'host',
  remotes: {
    dashboard: 'http://localhost:3001/assets/remoteEntry.js',
    orders: 'http://localhost:3002/assets/remoteEntry.js',
  },
  shared: ['react', 'react-dom', '@cloudscape-design/components'],
})
```

### **Environment Variables**

Create `.env` files for environment-specific configuration:

```bash
# .env.development
VITE_API_URL=http://localhost:8080
VITE_DASHBOARD_URL=http://localhost:3001
VITE_ORDERS_URL=http://localhost:3002

# .env.production
VITE_API_URL=https://api.production.com
VITE_DASHBOARD_URL=https://dashboard.production.com
VITE_ORDERS_URL=https://orders.production.com
```

## 🧪 Testing

### **Running Tests**

```bash
# Run all tests
make test

# Run tests for specific package
cd host && pnpm test
cd mfe-dashboard && pnpm test
cd mfe-orders && pnpm test

# Run tests in watch mode
make test-watch
```

### **Testing Strategy**

- **Unit Tests**: Component and utility function testing
- **Integration Tests**: Module Federation integration
- **E2E Tests**: Full application workflow testing
- **Visual Regression Tests**: UI component testing

## 📦 Build & Deployment

### **Production Build**

```bash
# Build all applications
make build

# Build artifacts will be in:
# host/dist/
# mfe-dashboard/dist/
# mfe-orders/dist/
```

### **Deployment Options**

1. **Static Hosting** (Netlify, Vercel, S3)
   ```bash
   make build
   # Deploy dist/ folders to your hosting provider
   ```

2. **Docker Deployment**
   ```bash
   make docker-build
   make docker-prod
   ```

3. **Kubernetes Deployment**
   ```bash
   # Apply Kubernetes manifests
   kubectl apply -f k8s/
   ```

### **CI/CD Pipeline**

Example GitHub Actions workflow:

```yaml
name: Build and Deploy
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - uses: pnpm/action-setup@v2
        with:
          version: 8
      - run: make install
      - run: make build
      - run: make test
```

## 🤝 Contributing

### **Development Guidelines**

1. **Code Style**
   - Use TypeScript for all new code
   - Follow ESLint and Prettier configurations
   - Write meaningful commit messages

2. **Micro Frontend Development**
   - Keep MFEs independent and self-contained
   - Use shared dependencies sparingly
   - Document exposed components and APIs

3. **Testing**
   - Write tests for new features
   - Maintain test coverage above 80%
   - Test Module Federation integration

### **Pull Request Process**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Update documentation
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### **Common Issues**

1. **Module Federation Errors**
   ```bash
   # Clear build cache
   make clean
   # Reinstall dependencies
   make install
   # Rebuild
   make build
   ```

2. **Port Conflicts**
   ```bash
   # Check what's using the ports
   lsof -i :3000
   lsof -i :3001
   lsof -i :3002
   ```

3. **Docker Issues**
   ```bash
   # Clean Docker resources
   make docker-clean
   # Rebuild images
   make docker-build
   ```

### **Getting Help**

- Check the [Issues](../../issues) page for known problems
- Review the [Docker documentation](DOCKER.md)
- Consult the [Makefile reference](MAKEFILE_QUICK_REFERENCE.md)

## 🔗 Related Documentation

- [Docker Setup Guide](DOCKER.md)
- [Makefile Quick Reference](MAKEFILE_QUICK_REFERENCE.md)
- [Gitignore Summary](GITIGNORE_SUMMARY.md)
- [AWS Cloudscape Design System](https://cloudscape.design/)
- [Vite Module Federation](https://github.com/originjs/vite-plugin-federation)
- [Turbo Documentation](https://turbo.build/repo/docs)

---

**Happy coding! 🚀**
