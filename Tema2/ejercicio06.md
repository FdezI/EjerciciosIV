[-- Ejercicio 5 --](./ejercicio05.md)

-------------------

## Ejercicios 6

### Crear una jaula y enjaular un usuario usando `jailkit`, que previamente se habrá tenido que instalar.

Instalamos jailkit:

    $ wget http://olivier.sessink.nl/jailkit/jailkit-2.17.tar.gz

    $ tar xzf jailkit-2.17.tar.gz

    $ cd jailkit-2.17
    $ make
    # make install


Creamos la carpeta contenedora de nuestras "jaulas":

    # mkdir -p /home/chroots/jailkit

Apropiamos a root:

    # chown root:root /home/chroots/jailkit

Creamos el entorno:

    # jk_init -v -j /home/chroots/jailkit jk_lsh basicshell netutils editors ssh scp

Creamos al usuario y lo encerramos:

    # useradd -c "Jailed user" -g users userj
    # passwd userj
    # jk_jailuser -m -j /home/chroots/jailkit/ userj

Editamos el fichero /etc/passwd para darle la shell bash al usuario (recomendado, ya que aunque se la diéramos en el "useradd" el posterior "jk_jailuser" la machacará con una propia):

    # vim /etc/passwd


Llegados a este punto está (si no se ha cometido ningún error ni saltado ningún paso) todo listo para conectarse a la jaula:


------------------

> Más info: http://olivier.sessink.nl/jailkit/howtos_chroot_shell.html

------------------

[-- Ejercicio 7 --](./ejercicio07.md)
