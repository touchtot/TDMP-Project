FROM nginx:latest
COPY ./web_test/* /usr/share/nginx/html/index.html
CMD chmod 777 /usr/share/nginx/html
