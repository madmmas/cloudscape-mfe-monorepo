#!/bin/bash

# Docker Setup Script for Cloudscape MFE Monorepo

set -e

echo "🐳 Cloudscape MFE Docker Setup"
echo "================================"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop and try again."
    exit 1
fi

echo "✅ Docker is running"

# Function to display usage
show_usage() {
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  build-prod    - Build production containers"
    echo "  build-dev     - Build development containers"
    echo "  start-prod    - Start production environment"
    echo "  start-dev     - Start development environment"
    echo "  stop-prod     - Stop production environment"
    echo "  stop-dev      - Stop development environment"
    echo "  logs-prod     - View production logs"
    echo "  logs-dev      - View development logs"
    echo "  clean         - Clean up containers and images"
    echo "  help          - Show this help message"
    echo ""
}

# Function to build production containers
build_prod() {
    echo "🔨 Building production containers..."
    docker-compose build
    echo "✅ Production containers built successfully"
}

# Function to build development containers
build_dev() {
    echo "🔨 Building development containers..."
    docker-compose -f docker-compose.dev.yml build
    echo "✅ Development containers built successfully"
}

# Function to start production environment
start_prod() {
    echo "🚀 Starting production environment..."
    docker-compose up -d
    echo "✅ Production environment started"
    echo "📱 Access your applications:"
    echo "   - Host App: http://localhost:3000"
    echo "   - Dashboard: http://localhost:3001"
    echo "   - Orders: http://localhost:3002"
}

# Function to start development environment
start_dev() {
    echo "🚀 Starting development environment..."
    docker-compose -f docker-compose.dev.yml up -d
    echo "✅ Development environment started"
    echo "📱 Access your applications:"
    echo "   - Host App: http://localhost:3000"
    echo "   - Dashboard: http://localhost:3001"
    echo "   - Orders: http://localhost:3002"
}

# Function to stop production environment
stop_prod() {
    echo "🛑 Stopping production environment..."
    docker-compose down
    echo "✅ Production environment stopped"
}

# Function to stop development environment
stop_dev() {
    echo "🛑 Stopping development environment..."
    docker-compose -f docker-compose.dev.yml down
    echo "✅ Development environment stopped"
}

# Function to view production logs
logs_prod() {
    echo "📋 Production logs:"
    docker-compose logs -f
}

# Function to view development logs
logs_dev() {
    echo "📋 Development logs:"
    docker-compose -f docker-compose.dev.yml logs -f
}

# Function to clean up
clean() {
    echo "🧹 Cleaning up containers and images..."
    docker-compose down --rmi all --volumes --remove-orphans
    docker-compose -f docker-compose.dev.yml down --rmi all --volumes --remove-orphans
    docker system prune -f
    echo "✅ Cleanup completed"
}

# Main script logic
case "${1:-help}" in
    build-prod)
        build_prod
        ;;
    build-dev)
        build_dev
        ;;
    start-prod)
        start_prod
        ;;
    start-dev)
        start_dev
        ;;
    stop-prod)
        stop_prod
        ;;
    stop-dev)
        stop_dev
        ;;
    logs-prod)
        logs_prod
        ;;
    logs-dev)
        logs_dev
        ;;
    clean)
        clean
        ;;
    help|*)
        show_usage
        ;;
esac 