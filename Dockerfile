# Multi-stage Dockerfile: build frontend + backend and serve static from Express

# --- Stage 1: build frontend ---
FROM node:18-alpine AS frontend-builder
WORKDIR /usr/src/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/. ./
RUN npm run build

# --- Stage 2: build backend and copy frontend dist ---
FROM node:18-alpine AS backend
WORKDIR /usr/src/app
COPY backend/package*.json ./
RUN npm install --production
COPY backend/. ./

# Copy built frontend into backend runtime tree
COPY --from=frontend-builder /usr/src/frontend/dist ./frontend/dist

# Optional (if you want to reduce image size by removing dev dependencies in backend stage):
# RUN npm prune --production

EXPOSE 3000
ENV NODE_ENV=production
ENV PORT=3000

CMD ["npm", "start"]
