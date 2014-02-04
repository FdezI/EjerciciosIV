[-- Ejercicio 3 --](./ejercicio03.md)

-----------------


## Ejercicios 4

### Crear uno o varios sistema de ficheros en bucle usando un formato que no sea habitual (xfs o btrfs) y comparar las prestaciones de entrada/salida entre sí y entre ellos y el sistema de ficheros en el que se encuentra, para comprobar el overhead que se añade mediante este sistema

Vamos a realizar una comparación de rendimiento de 4 sistemas de ficheros distintos entre sí (xfs, btrfs, ntfs y ext4).
Lo primero es asegurarnos de poder crear todos estos sistemas de ficheros, para ello:

    # apt-get install xfsprogs btrfs-tools ntfs-3g

A continuación creamos las 4 imágenes distintas cada una con su sistema de ficheros asociado:

    $ qemu-img create -f raw xfs.img 1G
    $ qemu-img create -f raw btrfs.img 1G
    $ qemu-img create -f raw ntfs.img 1G
    $ qemu-img create -f raw ext4.img 1G


Las montamos en un dispositivo loop:

    # losetup -f xfs.img
    # losetup -f btrfs.img
    # losetup -f ntfs.img
    # losetup -f ext4.img


Les damos formato:

    # mkfs.xfs /dev/loop0
    # mkfs.btrfs /dev/loop1
    # mkfs.ntfs -f /dev/loop2
    # mkfs.ext4 /dev/loop3


Las montamos en nuestro sistema de ficheros:
    # mkdir /mnt/xfs /mnt/btrfs /mnt/ntfs /mnt/ext4

    # mount /dev/loop0 /mnt/xfs
    # mount /dev/loop1 /mnt/btrfs
    # mount /dev/loop2 /mnt/ntfs
    # mount /dev/loop3 /mnt/ext4


Antes de empezar a comprar velocidades necesitaremos un fichero dedicado a tal fin. Creamos el fichero (500MB):

    $ dd if=/dev/urandom of=testFile bs=1k count=524288

Copiamos el fichero a cada uno de los sistemas (esperando a que termine siempre el anterior y bajo las mismas condiciones) midiendo su tiempo con la órden "time".
Los resultados mostrados a continuación se han obtenido mediante el uso de [este script](./scripts/speeds.sh).


------------------

[-- Ejercicio 5 --](./ejercicio05.md)
