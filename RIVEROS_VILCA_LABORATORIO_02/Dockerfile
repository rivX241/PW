FROM ubuntu:20.04
ENV TZ=America/Lima
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > etc/timezone
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y apache2 \
    && apt-get install -y apache2-utils \
    && apt-get clean
    EXPOSE 90
COPY ./proyectoweb /var/www/html/
CMD ["apache2ctl", "-D","FOREGROUND"]
