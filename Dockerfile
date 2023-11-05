FROM node:14.20.0 AS builder
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

# Copy the entire Angular project he
COPY . .

# Build the Angular appedit 
RUN npm run build --prod

# Stage 2: Serve the production build using Nginx
FROM nginx:alpine
COPY nginx.conf  /etc/nginx/conf.d/default.conf
# Copy the build artifacts from the previous stage
COPY --from=builder /app/dist/crudtuto-Front /usr/share/nginx/html


# Expose port 80 (the default port for HTTP traffic)
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
