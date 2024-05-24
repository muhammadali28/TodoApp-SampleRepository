# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Final stage
FROM nginx:latest

COPY --from=builder /app/build /usr/share/nginx/html