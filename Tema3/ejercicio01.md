[-- Tema 2, ejercicio 6 --](../Tema2/ejercicio06.md)

-----------------


## Ejercicios 1

### Instala LXC en tu versión de Linux favorita. Normalmente la versión en desarrollo, disponible tanto en [GitHub](http://github.com/lxc/lxc) como en el [sitio web](http://linxcontainers.com/) está bastante más avanzada; para evitar problemas sobre todo con las herramientas que vamos a ver más adelante, conviene que te instales la última versión y si es posible una igual o mayor a la 1.0.

Para saber las versiones disponibles en los repositorios:

    # apt-cache policy lxc

Para instalar la versión del respositorio concreto:

    # apt-get install lxc -t quantal-backports

> Para activar los repositorios "backports" descontemos la línea correspondiente en `/etc/apt/sources.list`


-----------------

[-- Ejercicio 2 --](./ejercicio02.md)
