# Usa una imagen base ligera
FROM bitnami/minideb:latest

# Actualiza los paquetes e instala Apache, Perl y el módulo CGI
RUN install_packages apache2 perl libapache2-mod-perl2 libcgi-pm-perl

# Habilita el módulo CGI en Apache
RUN a2enmod cgi

# Establecer el ServerName globalmente para evitar advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Crea los directorios necesarios para la aplicación
WORKDIR /var/www/html

# Copia el archivo index.html y la carpeta css al directorio raíz de Apache
COPY index.html /var/www/html/
COPY css/ /var/www/html/css/

# Copia el script Perl a la carpeta cgi-bin de Apache
COPY cgi-bin/calculadora.pl /usr/lib/cgi-bin/

# Da permisos de ejecución al script Perl
RUN chmod +x /usr/lib/cgi-bin/calculadora.pl

# Expon el puerto 80 para el servidor web
EXPOSE 80

# Inicia Apache en el contenedor
CMD ["apachectl", "-D", "FOREGROUND"]
