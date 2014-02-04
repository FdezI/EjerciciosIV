[-- Ejercicio 2 --](./ejercicio02.md)

-----------------


## Ejercicios 3

### Crear imágenes con estos formatos (y otros que se encuentren tales como VMDK) y manipularlas a base de montarlas o con cualquier otra utilidad que se encuentre.

Para manipular las imágenes primero deberemos crearlas. A continuación se mostrarán distintas formas de crear una imagen y tres formatos muy usados.

#### Creción de imágenes de 5M usando distintos formatos:

Los tres formatos en cuestión serán raw (crudo, sin compresión ninguna), qcow2 y vmdk (usado por vmware).

##### Formato raw (3 formas):

1. "A pelo":

        $ dd of=raw1.img bs=1k seek=5120 count=0

    > Donde a1.img es el nombre de la imagen, bs el tamaño de bloque y seek el tamaño del fichero en la unidad especificada en bs (5M * 1024K = 5120K)

    > La instrucción `$ ls -lks` muestra cuántos bloques han sido ocupados realmente (s) y de cuántos bloques es la imagen (k). Si se usa `$ ls -h` se verá en formato "humano" el tamaño de la imagen.

2. "File allocation":

	$ fallocate -l 5M raw2.img 

3. Qemu:

        $ qemu-img create -f raw raw3.img 5M


##### Formato qcow2:

Instalamos las `qemu-utils`:

    # apt-get install qemu-utils

Creamos la imagen:

    $ qemu-img create -f qcow2 qcow1.qcow2 5M

##### Formato vmdk:

Con las `qemu-utils` instaladas:

    $ qemu-img create -f vmdk vmdk1.vmdk 5M

Otra forma de ver información de estas imágenes (aparte del `ls`) es con:

    $ qemu-img info <imagen>


#### Manipulación

A continuación, montaremos estas imágenes para su uso, pero antes, deberemos formatearlos con el sistema de ficheros que deseemos, en este caso, ext4:

Para poder darles formato hay que convertir cada imagen en un "dispositivo loop", lo cual se consigue con: 

    # losetup -v -f raw1.img

> Si usamos el parámetro -v debería decirnos el dispositivo que se ha creado (normalmente, /dev/loopX, donde x es el índice del loop creado).

Le damos el formato:

    # mkfs.ext4 /dev/loop0

Montamos el "dispositivo" en el directorio deseado (debe existir):

    # mount /dev/loop0 /mnt/raw1/

En caso de querer montar la imagen sin la necesidad de anclarla previamente a un dispositivo loop podemos montarla directamente con:

    #  mount -o loop raw1.img /mnt/raw1/

> De esta forma, el sistema creará el dispositivo automáticamente al montarla (se puede comprobar con `# losetup -a`) y lo "destruirá" automáticamente al desmontarla.
	

> Con la órden `# df -h` (-h = human readable), podremos ver nuestros dispositivos montados (`# mount` también nos vale).


> Aunque pueden montarse todos bajo la misma ruta no es aconsajable ya que perdería su finalidad, puesto que el único "dispositivo" accesible sería el último montado, al contrario de la idea de que todos son accesibles..... (si se piensa no tiene mucho sentido).


> Podemos ver los dispositivos loop actuales en cualquier momento con la órden: `# losetup -a`, también podemos "desanclar" un dispositivo loop con: `# losetup -d /dev/loopX`


------------------

[-- Ejercicio 4 --](./ejercicio04.md)
