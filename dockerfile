# Build Phase
# Use node:alpine for our base image and tag it as 'builder'
FROM node:alpine as builder

# Set our working directory
WORKDIR /app

# Copy our dependencies list and install them
COPY package.json ./
RUN npm install

# Copy the code
COPY . .

# Build the project
RUN npm run build


# Run Phase
# Define start of another phase using a FROM statement
FROM nginx

# Copy the compiled project from the builder container 
COPY --from=builder /app/build /usr/share/nginx/html