FROM ubuntu:18.04
LABEL maintainer="geek-rb"
RUN apt-get update && apt-get upgrade -y
RUN apt-get install nginx -y
ARG DEVOPS
#ENV DEVOPS1=%DEVOPS%
ENV DEVOPS=$DEVOPS
#ENV DEVOPS3=$env:DEVOPS
#RUN setx /M DEVOPS "%DEVOPS%"
EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]