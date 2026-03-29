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

# Build the app
RUN npm run build

# =========================
# Stage 2: Serve with Nginx
# =========================
FROM nginx:stable-alpine

# Copy build output to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html



# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]