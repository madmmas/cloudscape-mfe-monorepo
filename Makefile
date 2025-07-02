# Cloudscape MFE Monorepo Makefile
# ======================================

# Variables
# ---------
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_DEV = docker-compose -f docker-compose.dev.yml
PNPM = pnpm
NODE_ENV ?= development

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
PURPLE = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[1;37m
NC = \033[0m # No Color

# Default target
.DEFAULT_GOAL := help

# Help target
.PHONY: help
help: ## Show this help message
	@echo "$(CYAN)Cloudscape MFE Monorepo$(NC)"
	@echo "$(CYAN)=====================$(NC)"
	@echo ""
	@echo "$(YELLOW)Available commands:$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(YELLOW)Examples:$(NC)"
	@echo "  make install          # Install dependencies"
	@echo "  make dev              # Start development servers"
	@echo "  make build            # Build all packages"
	@echo "  make docker-prod      # Start production Docker environment"
	@echo "  make docker-dev       # Start development Docker environment"

# Development Commands
# -------------------

.PHONY: install
install: ## Install all dependencies
	@echo "$(BLUE)Installing dependencies...$(NC)"
	$(PNPM) install
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

.PHONY: dev
dev: ## Start all development servers
	@echo "$(BLUE)Starting development servers...$(NC)"
	$(PNPM) dev

.PHONY: dev-host
dev-host: ## Start only the host development server
	@echo "$(BLUE)Starting host development server...$(NC)"
	$(PNPM) --filter host dev

.PHONY: dev-dashboard
dev-dashboard: ## Start only the dashboard development server
	@echo "$(BLUE)Starting dashboard development server...$(NC)"
	$(PNPM) --filter mfe-dashboard dev

.PHONY: dev-orders
dev-orders: ## Start only the orders development server
	@echo "$(BLUE)Starting orders development server...$(NC)"
	$(PNPM) --filter mfe-orders dev

# Build Commands
# --------------

.PHONY: build
build: ## Build all packages
	@echo "$(BLUE)Building all packages...$(NC)"
	$(PNPM) build
	@echo "$(GREEN)✓ All packages built$(NC)"

.PHONY: build-host
build-host: ## Build only the host package
	@echo "$(BLUE)Building host package...$(NC)"
	$(PNPM) --filter host build
	@echo "$(GREEN)✓ Host package built$(NC)"

.PHONY: build-dashboard
build-dashboard: ## Build only the dashboard package
	@echo "$(BLUE)Building dashboard package...$(NC)"
	$(PNPM) --filter mfe-dashboard build
	@echo "$(GREEN)✓ Dashboard package built$(NC)"

.PHONY: build-orders
build-orders: ## Build only the orders package
	@echo "$(BLUE)Building orders package...$(NC)"
	$(PNPM) --filter mfe-orders build
	@echo "$(GREEN)✓ Orders package built$(NC)"

# Docker Commands
# ---------------

.PHONY: docker-build
docker-build: ## Build all Docker containers
	@echo "$(BLUE)Building Docker containers...$(NC)"
	$(DOCKER_COMPOSE) build
	@echo "$(GREEN)✓ Docker containers built$(NC)"

.PHONY: docker-build-dev
docker-build-dev: ## Build development Docker containers
	@echo "$(BLUE)Building development Docker containers...$(NC)"
	$(DOCKER_COMPOSE_DEV) build
	@echo "$(GREEN)✓ Development Docker containers built$(NC)"

.PHONY: docker-prod
docker-prod: ## Start production Docker environment
	@echo "$(BLUE)Starting production Docker environment...$(NC)"
	$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)✓ Production environment started$(NC)"
	@echo "$(CYAN)Host App: http://localhost:3000$(NC)"
	@echo "$(CYAN)Dashboard: http://localhost:3001$(NC)"
	@echo "$(CYAN)Orders: http://localhost:3002$(NC)"

.PHONY: docker-dev
docker-dev: ## Start development Docker environment
	@echo "$(BLUE)Starting development Docker environment...$(NC)"
	$(DOCKER_COMPOSE_DEV) up -d
	@echo "$(GREEN)✓ Development environment started$(NC)"
	@echo "$(CYAN)Host App: http://localhost:3000$(NC)"
	@echo "$(CYAN)Dashboard: http://localhost:3001$(NC)"
	@echo "$(CYAN)Orders: http://localhost:3002$(NC)"

.PHONY: docker-stop
docker-stop: ## Stop all Docker containers
	@echo "$(BLUE)Stopping Docker containers...$(NC)"
	$(DOCKER_COMPOSE) down
	@echo "$(GREEN)✓ Docker containers stopped$(NC)"

.PHONY: docker-stop-dev
docker-stop-dev: ## Stop development Docker containers
	@echo "$(BLUE)Stopping development Docker containers...$(NC)"
	$(DOCKER_COMPOSE_DEV) down
	@echo "$(GREEN)✓ Development Docker containers stopped$(NC)"

.PHONY: docker-logs
docker-logs: ## Show Docker container logs
	@echo "$(BLUE)Showing Docker container logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f

.PHONY: docker-logs-dev
docker-logs-dev: ## Show development Docker container logs
	@echo "$(BLUE)Showing development Docker container logs...$(NC)"
	$(DOCKER_COMPOSE_DEV) logs -f

.PHONY: docker-clean
docker-clean: ## Clean up Docker containers, images, and volumes
	@echo "$(BLUE)Cleaning up Docker resources...$(NC)"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
	$(DOCKER_COMPOSE_DEV) down --rmi all --volumes --remove-orphans
	docker system prune -f
	@echo "$(GREEN)✓ Docker cleanup completed$(NC)"

# Testing Commands
# ---------------

.PHONY: test
test: ## Run all tests
	@echo "$(BLUE)Running all tests...$(NC)"
	$(PNPM) test
	@echo "$(GREEN)✓ Tests completed$(NC)"

.PHONY: test-host
test-host: ## Run host tests
	@echo "$(BLUE)Running host tests...$(NC)"
	$(PNPM) --filter host test
	@echo "$(GREEN)✓ Host tests completed$(NC)"

.PHONY: test-dashboard
test-dashboard: ## Run dashboard tests
	@echo "$(BLUE)Running dashboard tests...$(NC)"
	$(PNPM) --filter mfe-dashboard test
	@echo "$(GREEN)✓ Dashboard tests completed$(NC)"

.PHONY: test-orders
test-orders: ## Run orders tests
	@echo "$(BLUE)Running orders tests...$(NC)"
	$(PNPM) --filter mfe-orders test
	@echo "$(GREEN)✓ Orders tests completed$(NC)"

# Linting Commands
# ---------------

.PHONY: lint
lint: ## Run linting on all packages
	@echo "$(BLUE)Running linting...$(NC)"
	$(PNPM) lint
	@echo "$(GREEN)✓ Linting completed$(NC)"

.PHONY: lint-fix
lint-fix: ## Fix linting issues automatically
	@echo "$(BLUE)Fixing linting issues...$(NC)"
	$(PNPM) lint --fix
	@echo "$(GREEN)✓ Linting fixes applied$(NC)"

# Utility Commands
# ---------------

.PHONY: clean
clean: ## Clean build artifacts
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	rm -rf host/dist mfe-dashboard/dist mfe-orders/dist
	@echo "$(GREEN)✓ Build artifacts cleaned$(NC)"

.PHONY: clean-all
clean-all: clean ## Clean build artifacts and node_modules
	@echo "$(BLUE)Cleaning node_modules...$(NC)"
	rm -rf node_modules host/node_modules mfe-dashboard/node_modules mfe-orders/node_modules
	@echo "$(GREEN)✓ All artifacts cleaned$(NC)"

.PHONY: status
status: ## Show current status of services
	@echo "$(CYAN)Current Status:$(NC)"
	@echo "$(BLUE)Docker Containers:$(NC)"
	@$(DOCKER_COMPOSE) ps 2>/dev/null || echo "$(YELLOW)No Docker containers running$(NC)"
	@echo ""
	@echo "$(BLUE)Port Usage:$(NC)"
	@echo "$(CYAN)Port 3000:$(NC) $$(lsof -ti:3000 2>/dev/null | wc -l | tr -d ' ') processes"
	@echo "$(CYAN)Port 3001:$(NC) $$(lsof -ti:3001 2>/dev/null | wc -l | tr -d ' ') processes"
	@echo "$(CYAN)Port 3002:$(NC) $$(lsof -ti:3002 2>/dev/null | wc -l | tr -d ' ') processes"

.PHONY: check-ports
check-ports: ## Check if required ports are available
	@echo "$(BLUE)Checking port availability...$(NC)"
	@for port in 3000 3001 3002; do \
		if lsof -ti:$$port >/dev/null 2>&1; then \
			echo "$(RED)✗ Port $$port is in use$(NC)"; \
		else \
			echo "$(GREEN)✓ Port $$port is available$(NC)"; \
		fi; \
	done

.PHONY: serve-dashboard
serve-dashboard: ## Serve dashboard build with CORS
	@echo "$(BLUE)Serving dashboard build on port 3001...$(NC)"
	cd mfe-dashboard && npx serve dist -p 3001 --cors

.PHONY: serve-orders
serve-orders: ## Serve orders build with CORS
	@echo "$(BLUE)Serving orders build on port 3002...$(NC)"
	cd mfe-orders && npx serve dist -p 3002 --cors

.PHONY: serve-all
serve-all: ## Serve all builds (requires separate terminals)
	@echo "$(YELLOW)Starting all serve processes...$(NC)"
	@echo "$(CYAN)Terminal 1:$(NC) make serve-dashboard"
	@echo "$(CYAN)Terminal 2:$(NC) make serve-orders"
	@echo "$(CYAN)Terminal 3:$(NC) make dev-host"

# Quick Start Commands
# -------------------

.PHONY: quick-start
quick-start: install build docker-prod ## Quick start: install, build, and start production
	@echo "$(GREEN)✓ Quick start completed!$(NC)"
	@echo "$(CYAN)Access your application at: http://localhost:3000$(NC)"

.PHONY: quick-start-dev
quick-start-dev: install dev ## Quick start development: install and start dev servers
	@echo "$(GREEN)✓ Development quick start completed!$(NC)"
	@echo "$(CYAN)Access your application at: http://localhost:3000$(NC)"

# Production Deployment
# --------------------

.PHONY: deploy
deploy: clean build docker-build docker-prod ## Full production deployment
	@echo "$(GREEN)✓ Production deployment completed!$(NC)"
	@echo "$(CYAN)Application is running at: http://localhost:3000$(NC)"

.PHONY: deploy-dev
deploy-dev: clean build docker-build-dev docker-dev ## Full development deployment
	@echo "$(GREEN)✓ Development deployment completed!$(NC)"
	@echo "$(CYAN)Application is running at: http://localhost:3000$(NC)"

# Monitoring Commands
# ------------------

.PHONY: logs
logs: ## Show all logs (Docker + development)
	@echo "$(BLUE)Showing all logs...$(NC)"
	@echo "$(YELLOW)Docker logs:$(NC)"
	@$(DOCKER_COMPOSE) logs --tail=50 || echo "$(YELLOW)No Docker logs available$(NC)"
	@echo ""
	@echo "$(YELLOW)Development logs:$(NC)"
	@echo "$(CYAN)Use 'make dev' to see development logs$(NC)"

.PHONY: health-check
health-check: ## Check health of all services
	@echo "$(BLUE)Performing health checks...$(NC)"
	@echo "$(CYAN)Host App (port 3000):$(NC)"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 || echo "000"
	@echo ""
	@echo "$(CYAN)Dashboard (port 3001):$(NC)"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3001 || echo "000"
	@echo ""
	@echo "$(CYAN)Orders (port 3002):$(NC)"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3002 || echo "000"
	@echo ""

# Development Workflow
# -------------------

.PHONY: dev-workflow
dev-workflow: ## Complete development workflow
	@echo "$(BLUE)Starting development workflow...$(NC)"
	@echo "$(YELLOW)1. Installing dependencies...$(NC)"
	@$(MAKE) install
	@echo "$(YELLOW)2. Building packages...$(NC)"
	@$(MAKE) build
	@echo "$(YELLOW)3. Starting development servers...$(NC)"
	@$(MAKE) dev

.PHONY: prod-workflow
prod-workflow: ## Complete production workflow
	@echo "$(BLUE)Starting production workflow...$(NC)"
	@echo "$(YELLOW)1. Installing dependencies...$(NC)"
	@$(MAKE) install
	@echo "$(YELLOW)2. Building packages...$(NC)"
	@$(MAKE) build
	@echo "$(YELLOW)3. Building Docker containers...$(NC)"
	@$(MAKE) docker-build
	@echo "$(YELLOW)4. Starting production environment...$(NC)"
	@$(MAKE) docker-prod 