# Dockerfile for Dhananjayan Fashions backend Node.js app
# 1. Use official Node.js runtime as the base image
FROM node:18-alpine

# 2. Create app directory
WORKDIR /usr/src/app

# 3. Copy package definitions and install dependencies first (cache layer benefit)
COPY backend/package*.json ./
RUN npm install --production

# 4. Copy the rest of the app source
COPY backend/. ./

# 5. Expose port that the app uses (backend default 5000 or 3000, we use 3000 for demo)
EXPOSE 3000

# 6. Start the Node.js app
CMD ["npm", "start"]
