# Nginx-Lua
uses openresty lua module to decode JWT from http-header
- base64 encoded the payload
- set the encoded payload data to `X-headers`

### Usage
- Using Docker
  ```docker
  docker build -t nginx-img .
  ```
  ```bash
  docker run -e JWT_SECRET="your_jwt_secret" nginx-img
  ```
- Using Binary
  requires [openresty nginx](https://openresty.org/en/download.html)
  verify the nginx by `which nginx`

  to check the syntax
  ```bash
  nginx -p $PWD/ -t
  ```
  ```bash
  nginx -p $PWD/
  ```
  
  ### NOTE
  Default PORT `8080`
