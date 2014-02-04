[-- Ejercicio 5 --](./ejercicio05.md)

------------------

## Ejercicios 6

### Instalar una máquina virtual Debian usando Vagrant y conectar con ella.

El primer paso será instalar **Vagrant**:

    # apt-get install vagrant

A continuación, [consultaremos el nombre de la imagen deseada](http://www.vagrantbox.es/) e instalamos (con descarga incluida) la versión deseada, en este caso:

    $ vagrant box add squeeze http://dl.dropbox.com/u/54390273/vagrantboxes/Squeeze64_VirtualBox4.2.4.box


"Inicializamos" la máquina (creación de fichero de configuración en el directorio actual):

    $ vagrant init squeeze

> Por defecto, el fichero tendrá todos sus parámetros comentados (configuración de red, compartición de directorios, provisionamiento, etc) excepto el que le indica para qué máquina es dicha configuración.


Iniciamos la máquina con:

    $ vagrant up

Y nos conectamos a ella con:

    $ vagrant ssh


------------------

> Antes de elegir una "box" ya creada, se debería comprobar la versión y del hipervisor para la que ha sido creada para evitar incompatibilidades (`$ VboxManage --version`)

------------------

[-- Ejercicio 7 --](./ejercicio07.md)
