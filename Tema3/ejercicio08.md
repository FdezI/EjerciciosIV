[-- Ejercicio 7 --](./ejercicio07.md)

------------------


## Ejercicios 8

### Instalar libvirt. Te puede ayudar [esta guía para Ubuntu](https://help.ubuntu.com/12.04/serverguide/libvirt.html).

Instalamos **libvirt**:

    # apt-get install kvm libvirt-bin

Añadimos un usuario al grupo **"libvirtd"** para que pueda gestionar la librería instalada.

    # usermod $USER -a -G libvirtd

> Hay que tener en cuenta, que después de realizar modificaciones de grupos el usuario en cuestión deberá volver a entrar en su sesión (la asignación de grupos es aplicada en el momento de inicio de sesión del usuario).


------------------

[-- Ejercicio 9 --](./ejercicio09.md)
