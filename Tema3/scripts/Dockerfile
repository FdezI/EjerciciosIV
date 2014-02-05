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


# Instalación de módulos de python (mediante pip)
#RUN apt-get install python-pip
#RUN pip install webpy
#RUN pip install mako
#RUN pip install feedparser
#RUN pip install pymongo
#RUN pip install tweepy
