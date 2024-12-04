# Use the latest LTS version of Node.js
FROM node:lts

# Set the working directory
WORKDIR /app

# Copy only package.json and package-lock.json to leverage caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the default development server port
EXPOSE 5173

# Set the command to run the development server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
