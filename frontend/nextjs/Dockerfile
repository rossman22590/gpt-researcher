# Stage 1: Build the app using Node
FROM node:18.17.0-alpine as builder

# Set the working directory
WORKDIR /app

# Copy only package files first to leverage Docker cache
COPY ./package.json ./
# If you have a package-lock.json, copy it as well:
# COPY package-lock.json ./

# Install dependencies with legacy-peer-deps if needed
RUN npm install --legacy-peer-deps

# Copy the full source code into the image
COPY . .

# Run ESLint to verify code quality.
# - If you want the build to fail on lint errors, remove the "|| true".
RUN npx eslint --ext .js,.jsx,.ts,.tsx . || true
# Alternatively, if you have an npm script (e.g., "lint"), you could use:
# RUN npm run lint || true

# Build the app (creates /app/build or similar directory as configured)
RUN npm run build

# Stage 2: Serve the built static files with Nginx
FROM nginx

# Expose port 3000
EXPOSE 3000

# Copy the custom Nginx configuration file into the container
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the build output from the builder stage to Nginx's public folder
COPY --from=builder /app/build /usr/share/nginx/html