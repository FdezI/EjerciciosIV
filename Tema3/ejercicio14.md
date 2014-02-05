[-- Ejercicio 13 --](./ejercicio13.md)

------------------


## Ejercicios 13

### Crear una imagen con las herramientas necesarias para DAI sobre un sistema operativo de tu elección.

Los requisitos actuales de las prácticas de DAI son:

* python
* mongodb
* web.py
    * mako
    * feedparser
    * pymongo
    * tweepy




El [Dockerfile](./scripts/Dockerfile) resultante es el siguiente:


```
# DAI requirements
#
# VERSION               0.0.1
FROM      ubuntu
MAINTAINER Iñaki Fernández Janssens de Varebeke <inakitinajo@gmail.com>

# Instalación de dependencias para web.py
RUN apt-get update
RUN apt-get install python -y
RUN apt-get install mongodb-server -y

# Instalación de módulos de python
RUN apt-get install python-webpy -y
RUN apt-get install python-mako -y
RUN apt-get install python-feedparser -y
RUN apt-get install python-pymongo -y
RUN apt-get install python-tweepy -y
```


Ahora queda únicamente construir la imagen:

    # docker build -t FdezI/ubuntu_dai .


Con esto ya tenemos creada nuestra imagen. Si queremos subir imágenes propias al llamado "Docker Index" deberemos crearnos una cuenta y usar:

    # docker push FdezI/ubuntu_dai


------------------

> Más información acerca de crear imágenes: http://docs.docker.io/en/latest/use/builder/

------------------

[**-- Tema 4 --**](./Tema4)
