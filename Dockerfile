# Use an official nginx image as the base image
FROM nginx:alpine

# Copy the HTML and CSS files to the nginx web directory
COPY ./src /usr/share/nginx/html

# Copy the assets folder to the nginx web directory
COPY ./assets /usr/share/nginx/html/assets

# Expose port 80 to the outside world
EXPOSE 80
