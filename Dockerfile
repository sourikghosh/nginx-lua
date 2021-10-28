FROM openresty/openresty:1.19.9.1-0-alpine

# JWT_SECRET is mandatory
# ENV JWT_SECRET=""

WORKDIR /app

COPY lua /usr/local/openresty/nginx/lua
COPY conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN apk add curl 
RUN nginx -p /usr/local/openresty/nginx -t

EXPOSE 8080
