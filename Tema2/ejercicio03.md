[-- Ejercicio 2 --](./ejercicio02.md)

------------------------------------


## Ejercicios 3

### Usar debootstrap (o herramienta similar en otra distro) para crear un sistema mínimo que se pueda ejecutar más adelante.

Instalación del sistema debian elegido:

    # debootstrap sid chroots/sid http://ftp.es.debian.org/debian/

> Usado un mirror español para agilizar el procedimiento.

> Si no se dispone del comando debootstrap: `# apt-get install debootstrap`

![](./images/machines_comparision.png "Comparación entre el chroot y el anfitrión"
)

### Experimentar con la creación de un sistema Fedora dentro de Debian usando Rinse.

En el momento de usar el sistema con la herramienta chroot es recomendable montar los directorios básicos de todos sistema linux para evitar problemas:

    # mount --bind /dev chroots/sid/dev
    # mount -t proc proc chroots/sid/proc
    # mount -t sysfs sys chroots/sid/sys

Procedemos a entrar en el sistema virtualizable debian recién instalado e instalar el sistema fedora en su interior:	
    # chroot chroots/sid/
    # mkdir -p /home/chroots/fedora

    # rinse --arch amd64 --distribution fedora-core-10 --directory /home/chroots/fedora

> Si no se dispone del comando debootstrap: `# apt-get install rinse`

De esta forma ya tenemos instalada una versión virtualizable con chroot de fedora dentro de la distribución virtualizable de debian dentro de nuestro sistema Linux base.

Nuevamente, deberemos montar en él los directorios básicos de dispositivo, proceso y sistema ejecutando (estando rooteado en debian):

    # mount --bind /dev /home/chroots/fedora/dev
    # mount -t proc proc /home/chroots/fedora/proc
    # mount -t sysfs sys /home/chroots/fedora/sys

> Para acceder a ella: `# chroot /home/chroot/fedora/`

Si queremos que "chrootee" automáticamente:

    # useradd -s /bin/bash -m -d /home/inaki/chroots/sid/./home/userp -c "Usuario de pruebas" -g users userp
    # passwd userp

> El "." es el que provoca este comportamiento.


---------------------------------------

[-- Ejercicio 4 --](./ejercicio04.md)
