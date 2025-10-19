# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install git to clone repository
RUN apk add --no-cache git bash curl

# Clone Dataheri Restreamr repository
RUN git clone https://github.com/dataheri/Restreamr.git .

# Install Node.js dependencies
RUN npm install

# Expose port (Railway يستخدم 8080 عادة)
EXPOSE 8080

# Start the app
CMD ["npm", "start"]
