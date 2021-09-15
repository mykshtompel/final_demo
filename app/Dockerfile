# FROM is the base image for which we will run our application
FROM nginx:latest

# Copy files and directories from the application
COPY ./web/index.html /usr/share/nginx/html
COPY ./web/favicon.ico /usr/share/nginx/html
COPY ./web/Rakefile /usr/share/nginx/html
COPY ./web/style/ /usr/share/nginx/html/style/
COPY ./web/meta/ /usr/share/nginx/html/meta/
COPY ./web/js/ /usr/share/nginx/html/js/

# Tell Docker we are going to use this port
EXPOSE 80