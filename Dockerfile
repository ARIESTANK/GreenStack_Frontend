# 1. Use an official Node.js image as the build stage
FROM node:20-alpine AS builder

# 2. Set working directory
WORKDIR /app

# 3. Copy package.json and package-lock.json / yarn.lock
COPY package*.json ./

# 4. Install dependencies
RUN npm install

# 5. Copy the rest of the application
COPY . .

# 6. Build the React app
RUN npm run build

# -------------------------------
# 7. Use a lightweight web server for serving static files
FROM nginx:alpine

# 8. Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# 9. Copy built React app from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# 10. Copy custom nginx config if needed (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 11. Expose port 80
EXPOSE 80

# 12. Start nginx
CMD ["nginx", "-g", "daemon off;"]