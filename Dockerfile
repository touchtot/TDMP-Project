FROM nginx:stable-alpine
COPY web_test/* /usr/share/nginx/html/
RUN chmod -R 777 /usr/share/nginx/html
