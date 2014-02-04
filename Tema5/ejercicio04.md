[-- Ejercicio 3 --](./ejercicio03.md)

------------------


## Ejercicios 4

### Crear una máquina virtual Linux con 512 megas de RAM y entorno gráfico LXDE a la que se pueda acceder mediante VNC y ssh.

El comando a usar es el siguiente:

    virt-install --connect qemu:///system --name=lubuntu1 --ram=512 --vcpu=1 --disk=/var/lib/libvirt/images/lubuntu.img,bus=virtio,size=5 --graphics vnc,listen=0.0.0.0 --cdrom=/home/$USER/SOs/lubuntu-mini-i386.iso --noautoconsole

> Al indicar que se use vnc en la máquina virtual, el indicado de ejecutar el servicio de visualización remota será el anfitrión. Otra forma de obtener acceso por vnc sería instalando dicho servicio en la máquina invitada, lo cual consumiría los recursos de esta "en lugar" de la anfitriona (también varía ligeramente la configuración necesaria a nivel de firewall).

> De esta segunda forma es como accederemos mediante ssh, instalando en el sistema invitado el paquete `openssh-server`.




------------------

[-- Ejercicio 5 --](./ejercicio05.md)
