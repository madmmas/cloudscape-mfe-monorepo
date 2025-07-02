# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./
COPY pnpm-workspace.yaml ./

# Install pnpm
RUN npm install -g pnpm

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Install dependencies for the specific package
RUN cd host && pnpm install --frozen-lockfile

# Build the host application with production config
RUN cp host/vite.config.prod.ts host/vite.config.ts
RUN pnpm --filter host build

# Production stage
FROM nginx:alpine

# Copy built files from builder stage
COPY --from=builder /app/host/dist /usr/share/nginx/html

# Copy nginx configuration
COPY host/nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 