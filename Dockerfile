# =========================
# Stage 1: Build React app
# =========================
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all source files
COPY . .

# Build React app
RUN npm run build

# =========================
# Stage 2: Serve app using 'serve'
# =========================
FROM node:20-alpine

WORKDIR /app

# Install 'serve' globally
RUN npm install -g serve

# Copy build folder from previous stage
COPY --from=build /app/build ./build

# Set the PORT dynamically (Railway sets $PORT automatically)
ENV PORT $PORT

# Expose the port (for clarity)
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "build", "-l", "3000"]