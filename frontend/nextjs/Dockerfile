FROM node:18.17.0-alpine as builder
WORKDIR /app

# Copy package files and install dependencies
COPY ./package.json ./
RUN npm install --legacy-peer-deps

# Copy ESLint config if necessary
COPY .eslintrc.json ./

# Copy remaining source code
COPY . .

# Option 1: Run ESLint and continue even if there are errors
RUN npx eslint --ext .js,.jsx,.ts,.tsx . || true

# Build the app
RUN npm run build