[-- Ejercicio 1 --](./ejercicio01.md)

-----------------

## Ejercicios 2

### Comprobar qué interfaces puente se han creado y explicarlos.

Comprobamos que podemos usar lxc:

    # lxc-checkconfig

* Creamos un container llamado micaja con ubuntu:

        # lxc-create -t ubuntu -n micaja

> Tendremos que esperar a que se descargue el **so** y se instale en el container.


* También puede instalarse en su lugar mediante el template "cloud", el cual descarga e instala la distro de forma distinta:

        # lxc-create -t ubuntu-cloud -n minube

> Mientras de la primera forma se descargan todos los paquetes y se instalan (como las actualizaciones típicas), la segunda forma descarga primero un .tar.gz (mediante el uso del comando `wget`) y se instala a partir de él, agilizando el proceso.


*En ambas versiones el usuario y contraseña por defecto son: ubuntu*

Para ver nuestros contenederos disponibles podemos usar:

    # lxc-ls --fancy

> El --fancy proporciona detalles acerca de los containers.

Como podemos observar, los containers se encuentran detenidos, para iniciarlos:

    # lxc-start -n micaja
    # lxc-start -n minube

A continuación comprobaremos los interfaces puente (desde la máquina anfitriona):

    # brctl show

Lo cual nos mostrará que se ha creado una interfaz puente "lxcbr0" a la cual se les asocian tantas interfaces como máquinas virtualizando con lxd.

Si iniciamos la máquina veremos que además se crea una "vethXXXXXX", en este caso: vethF84R6N

-----------------

[-- Ejercicio 3 --](./ejercicio03.md)
