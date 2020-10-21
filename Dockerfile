# First Stage
# AWS fails with named builders
# FROM node:alpine as builder
FROM node:alpine

WORKDIR '/app'

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

# Second Stage
FROM nginx

# Documentation for developers
# But on elastic beanstalk the Expose 
# instruction will be used, beanstalk
# is automatically going to map to this port
EXPOSE 80

COPY --from=0 /app/build /usr/share/nginx/html

# Nginx will start automatically