FROM webdevops/php-nginx
ENV WEB_DOCUMENT_ROOT  /usr/share/nginx/html/
ENV WEB_DOCUMENT_INDEX index.html
COPY ./web_test/* /usr/share/nginx/html/
RUN chmod -R 777 /usr/share/nginx/html
