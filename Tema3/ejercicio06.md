[-- Ejercicio 5 --](./ejercicio05.md)

---------------


## Ejercicios 6

### Instalar juju.

Instalamos y configuramos juju:

    # add-apt-repository ppa:juju/stable
    # apt-get update && apt-get install juju-core

Creamos el directorio de configuración (~/.juju) con sus respectivos ficheros con la siguiente órden:

    $ juju init

Localizamos la línea `default: amazon` en el fichero **~/.juju/environments.yaml**, comentándola y añadiendo:
`default: local`

> (Con `$ juju switch [entorno]` podemos ver y cambiar el entorno en el que estamos trabajando)


Para poder trabajar en local necesitaremos tener MongoDB instalado, para ello:

    # apt-get install mongodb-server

Creamos un taper inicial:

    # juju bootstrap

* ** Error encontrado: ERROR no reachable servers **

    * Probado con `$ juju status -v`, con `$ juju bootstrap --debug` pero soltando siempre el mismo error.
    * Probado cambiar el puerto de **mongodb** al que intentaba conectarse en el error (*37017*) pero entonces en lugar de error se quedaba pillado, viendo que mongodb aceptaba la petición de conexión correctamente, en (`/var/log/mongodb/mongodb.log`).
    * Resulta que **juju** crea una instancia aparte de **mongodb** para su propio uso bajo el *puerto 37017* (gracias al irc de #juju) por lo que algún problema había con esta inicialización (no aparecía en el `ps aux | grep -i mongo` durante el "bootstrap"). Parece ser que juju crea un fichero en `/etc/init/juju-db-$USER-local.conf` con la configuración de inicialización de esta instancia.

        * Probando a ejecutar manualmente el comando citado podemos encontrarnos con que los parámetros usados no existen para nuestra versión de mongodb. Por lo tanto, probamos a actualizar. Esta vez funciona correctamente. (Curiosamente ya había probado a actualizar previamente y había eliminado el lock de mongodb por cerrado forzoso: "/var/lib/mongodb/mongod.lock" pero de alguna forma no había actualizado a la última versión)

    > El [script](./script/autojuju.sh) del [ejercicio 7](./ejercicio07.md) tiene esta posibilidad en cuenta


### Usándolo, instalar MySQL en un táper.

Depliegue de mysql:

    $ juju deploy mysql

Aunque en un inicio aparecerá que su estado es "pending", éste pasará a "started" tras un rato.


---------------

[-- Ejercicio 7 --](./ejercicio07.md)
