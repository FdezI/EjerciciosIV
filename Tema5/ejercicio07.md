[-- Ejercicio 6 --](./ejercicio06.md)

------------------

## Ejercicios 7

### Instalar una máquina virtual Ubuntu 12.04 para el hipervisor que tengas instalado.

Para realizar la instalación de una máquina virtual de forma automática y provisionar la misma podemos hacer uso de la herramienta "ubuntu-vm-builder". Para empezar, vamos a instalar las dependencias para realizar las pruebas:

    # apt-get install ubuntu-vm-builder kvm virt-manager

> Recordar que para ver si el sistema soporta kvm: `$ kvm-ok` y para activar el módulo respectivo del kernel: `# modprobe kvm-intel` o `# modprobe kvm-amd`


Creamos la máquina:

    #  vmbuilder kvm ubuntu --suite precise --flavour server --arch i386 --hostname vmbUbuntu --domain vmbUbuntu --user melki --m 512 --cpus 1 --pass asdfasdf --libvirt=qemu:///system --dest /vms/storage/ --addpkg=openssh-server --addpkg=vim --addpkg=bash-completion --addpkg=tree --mirror http://es.archive.ubuntu.com/ubuntu

> Atención al espacio en blanco antes de la instrucción, si se deja un espacio antes de ejecutar un comando en terminal, éste no queda guardado en el historial, muy útil para comandos que incluyen contraseñas y otros datos sensibles)


-------------------

> Para ver más opciones y parámetros recurrir al manual (`$ man vmbuilder`) o el manual online http://manpages.ubuntu.com/manpages/lucid/man1/vmbuilder.1.html

------------------

[**-- Tema 6 --**](./Tema6)
