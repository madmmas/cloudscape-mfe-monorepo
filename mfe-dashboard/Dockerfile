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
RUN cd mfe-dashboard && pnpm install --frozen-lockfile

# Build the dashboard application
RUN pnpm --filter mfe-dashboard build

# Production stage
FROM nginx:alpine

# Copy built files from builder stage
COPY --from=builder /app/mfe-dashboard/dist /usr/share/nginx/html

# Copy nginx configuration
COPY mfe-dashboard/nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 