FROM nginx:latest
COPY webtest/* /usr/share/nginx/html/index.html
CMD chmod 777 /usr/share/nginx/html
