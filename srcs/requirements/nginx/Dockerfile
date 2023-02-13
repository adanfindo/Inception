FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
	nginx \
	openssl

# SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/nginx.pem \
	-keyout /etc/nginx/ssl/nginx.key \
	-subj "/C=IT/ST=Rome/L=Rome/O=42/OU=tde-nico/CN=tde-nico.42.fr/emailAddress=tde-nico@student.42roma.it/"

# nginx config
RUN mkdir -p /run/nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
