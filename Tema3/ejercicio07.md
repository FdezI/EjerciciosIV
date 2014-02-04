[-- Ejercicio 6 --](./ejercicio06.md)

-----------------


## Ejercicios 7

### Destruir toda la configuración creada anteriormente.

Para destruir toda la configuración anteriormente, los pasos *"éticos"* serían los siguientes:

1. Destrucción de unidades de servicio:

        $ juju destroy-unit mysql/0

2. Destrucción de servicios:

        $ juju destroy-service mysql

3. Destrucción de máquinas:

        $ juju destroy-machine 1

4. Destrucción del entorno:

        # juju destroy-enviroment -y
	
Es decir, en orden inverso al de creación lógico. Sin embargo, si se destruye un recurso, todos los recursos que "cuelguen" del mismo también será destruido, por lo tanto, podemos eliminar toda la configuración de un solo golpe:

    # juju destroy-enviroment -y


### Volver a crear la máquina anterior y añadirle mediawiki y una relación entre ellos.

Creamos la máquina anterior:

    # juju bootstrap

    $ juju deploy mysql
    $ juju deploy mediawiki


Añadimos la relación:

    $ juju add-relation mediawiki:db mysql


En caso de querer hacer el servicio instalado accesible al público se hará con:

    $ juju expose mediawiki

De esta forma damos acceso al cualquier servicio desde el exterior del táper.


### Crear un script en shell para reproducir la configuración usada en las máquinas que hagan falta.

Para descargar y reproducir la configuración anterior con el [script](./scripts/autojuju.sh):

    # wget -q http://https://github.com/FdezI/EjerciciosIV/blob/master/Tema3/scripts/autojuju.sh -O /tmp/autojuju && bash /tmp/autojuju -x

El [script](./scripts/autojuju.sh), además, aporta otras funcionalidades. Para investigarlas:

    # ./autojuju.sh -h


-----------------

[-- Ejercicio 8 --](./ejercicio08.md)
