# Use the official Node.js image as the base
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if exists) to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code into the container
COPY . .

# Specify the port your Node.js app listens on
EXPOSE 3000

# Define the command to run your app
CMD ["node", "index.js"]



