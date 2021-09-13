FROM openresty/openresty:1.19.9.1-0-alpine

ENV JWT_SECRET="WINUALLBACKEND"

WORKDIR /app

COPY ./ ./

RUN nginx -p /app -t

RUN nginx -p /app