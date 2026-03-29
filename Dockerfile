# Use Debian-based Node to avoid Alpine build issues
FROM node:20-bullseye

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Build production version of React app
RUN npm run build

# Install 'serve' globally to serve the build
RUN npm install -g serve

# Expose Railway port (optional, clarity)
EXPOSE 3000

# Railway sets PORT dynamically
ENV PORT $PORT

# Serve the build folder on Railway's dynamic port
CMD ["sh", "-c", "serve -s build -l $PORT"]