FROM nginx:1.13.3-alpine

## Copy our nginx config
COPY server-config/nginx.conf /etc/nginx/nginx.conf

RUN chmod -R 777 /var/log/nginx /var/cache/nginx /var/run \
    && chmod -R g+rwX /etc/nginx \
    && rm /etc/nginx/conf.d/default.conf

## copy over the artifacts in dist folder to default nginx public folder
COPY dist/ /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]