FROM alpine:3.13.1
LABEL maintainer="geek-rb"
#RUN apt update && apt-get upgrade -y
#RUN apt install nginx -y
RUN apk -U add nginx
#ARG DEVOPS
#ENV DEVOPS1=%DEVOPS%
ENV DEVOPS=$DEVOPS
#ENV DEVOPS3=$env:DEVOPS
#RUN setx /M DEVOPS "%DEVOPS%"
EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]