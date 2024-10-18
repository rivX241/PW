docker build -t iriverosvilca .

docker run -d -p 8090:80 --name criverosvilca iriverosvilca

el uso del paquete dos2unix es para poder usar los archivos perl en docker en un so host windows debido a que emplea crlf en vez de lf como sistemas tipo unix lo que impidia la correcta
ejecucion de los scripts perl provocando un error en el servidor apache2
