# =========================
# Stage 1: Build React app
# =========================
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all source files
COPY . .

# Build the React app
RUN npm run build

# =========================
# Stage 2: Serve app using 'serve'
# =========================
FROM node:20-alpine

# Install 'serve' globally
RUN npm install -g serve

# Set working directory
WORKDIR /app

# Set the PORT environment variable dynamically
ENV PORT $PORT

# Expose port (optional, just for clarity)
EXPOSE 3000

# Start the app using 'serve'
CMD ["serve", "-s", "build", "-l", "3000"]