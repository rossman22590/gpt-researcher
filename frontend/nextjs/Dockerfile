# Stage 1: Build the Next.js app
FROM node:18.17.0-alpine as builder
WORKDIR /app

# Copy package files and install dependencies with legacy-peer-deps and forced install
COPY ./package.json ./
# If you have a package-lock.json or yarn.lock, copy them too:
# COPY package-lock.json ./
RUN npm install --legacy-peer-deps --force

# (Optional) Copy your ESLint configuration file if you use one
# This is helpful if you want to run ESLint even if its errors are ignored
COPY .eslintrc.json ./

# Copy the remaining source code into the image
COPY . .

# Run ESLint and ignore any errors (so they don't block the build)
RUN npx eslint --ext .js,.jsx,.ts,.tsx . || true

# Build the Next.js app (this assumes your package.json defines a "build" script)
RUN npm run build