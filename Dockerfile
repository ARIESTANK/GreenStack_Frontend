FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all source files
COPY . .

# Build React app
RUN npm run build

# Install 'serve' globally to serve the build
RUN npm install -g serve

# Expose port for Railway
EXPOSE 3000

# Use Railway dynamic PORT if provided
ENV PORT $PORT

# Start app with 'serve'
CMD ["serve", "-s", "build", "-l", "3000"]