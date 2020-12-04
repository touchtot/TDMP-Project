FROM nginx/stable-alpine
COPY ./web_test/asset /usr/share/nginx/html/
COPY ./web_test/index.html /usr/share/nginx/html/
RUN chmod -R 777 /usr/share/nginx/html
