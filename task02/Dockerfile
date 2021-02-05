FROM alpine:3.13.1
LABEL maintainer="geek-rb"
RUN apk -U add nginx \
#create pid for gnix because ver alpine 1.13.1;)
&& mkdir -p /run/nginx \
#create config www
&& printf 'server\n {listen 80 default_server;\nroot /var/www;\n}\n' > /etc/nginx/http.d/default.conf

ARG DEVOPS=$DEVOPS
ENV DEVOPS=$DEVOPS
EXPOSE 80

#create primitive wraper.sh
RUN printf '#!/bin/sh\n' > /home/wraper.sh \
&& printf 'echo "Run variable DEVOPS:$DEVOPS" > /var/www/index.html\n' >> /home/wraper.sh \
&& printf 'nginx -g "daemon off;"\n' >> /home/wraper.sh  \
&& chmod +x /home/wraper.sh

CMD ["./home/wraper.sh"]
