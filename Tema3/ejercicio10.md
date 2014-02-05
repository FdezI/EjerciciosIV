[-- Ejercicio 9 --](./ejercicio09.md)

------------------

## Ejercicios 10

### Instalar docker.

Actualizamos los repositorios y actualizamos nuestra versión del kernel:

    # apt-get update
    # apt-get install linux-image-extra-`uname -r`

Aunque Docker funciona mejor con versiones de kernel superiores a la 3.8, para estos ejercicios no es estrictamente necesario (Usando una 3.5.0-45)

Instalamos docker:

    # apt-get install lxc-docker


Para iniciar/detener/reiniciar docker:

    # service docker <start/stop/restart/status>

------------------

> Para una documentación de instalación más detallada: http://docs.docker.io/en/latest/installation/ubuntulinux/

------------------

[-- Ejercicio 11 --](./ejercicio11.md)
