FROM bitnami/minideb

ENV DEBIAN_FRONTEND="noninteractive"

# Actualizar e instalar dependencias
RUN apt-get update && \
    apt-get install -y apache2 perl vim bash locales tree libcgi-pm-perl dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurar locales
RUN echo -e 'LANG=es_PE.UTF-8\nLC_ALL=es_PE.UTF-8' > /etc/default/locale && \
    sed -i 's/^# *\(es_PE.UTF-8\)/\1/' /etc/locale.gen && \
    /sbin/locale-gen es_PE.UTF-8

# Crear directorios y ajustar permisos
RUN mkdir -p /var/www/html /usr/lib/cgi-bin && \
    chown www-data:www-data /usr/lib/cgi-bin /var/www/html && \
    chmod 750 /usr/lib/cgi-bin /var/www/html

# Configurar bash
RUN echo "export LC_ALL=es_PE.UTF-8" >> /root/.bashrc && \
    echo "export LANG=es_PE.UTF-8" >> /root/.bashrc && \
    echo "export LANGUAGE=es_PE.UTF-8" >> /root/.bashrc

# Copiar y convertir scripts y archivos HTML
COPY ./cgi-bin/ /usr/lib/cgi-bin/
RUN for file in /usr/lib/cgi-bin/*.pl; do \
    dos2unix "$file" && \
    chmod +x "$file"; \
done
COPY ./html/ /var/www/html/

# Configurar Apache para CGI
RUN echo '<VirtualHost *:80>\n\
    ServerAdmin webmaster@localhost\n\
    DocumentRoot /var/www/html\n\
    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/\n\
    <Directory "/usr/lib/cgi-bin">\n\
        AllowOverride None\n\
        Options +ExecCGI\n\
        Require all granted\n\
    </Directory>\n\
    <Directory "/var/www/html">\n\
        AllowOverride None\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Habilitar el módulo CGI
RUN a2enmod cgid

# Exponer puerto 90
EXPOSE 90

# Comando para iniciar Apache
CMD ["apachectl", "-D", "FOREGROUND"]