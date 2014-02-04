[-- Ejercicio 1 --](./ejercicio01.md)

-----------------


## Ejercicios 2

### Usar FUSE para acceder a recursos remotos como si fueran ficheros locales. Por ejemplo, sshfs para acceder a ficheros de una máquina virtual invitada o de la invitada al anfitrión.

En el caso de no tener el paquete sshfs instalado:

    # apt-get install sshfs

En el ejemplo siguiente se montará un direcotorio remoto (**/home/inaki/syncDir**) en un uno local (**/home/inaki/vmount**). El sistema remoto está bajo la IP **192.168.1.206**.

    # sshfs inaki@192.168.1.206:/home/inaki/syncDir/ ~/vmount

Aunque mediante otras utilidades de ssh, por ejemplo, **scp**, es posible usar el carácter **"~"** para indicar el "home" del usuario que está conectándose (en este caso inaki), mediante sshfs esto **no es posible**, obligándonos a usar la ruta completa para realizar el montaje.

Una vez realizado podremos comprobar que el contenido de los directorios syncDir y vmount es el mismo. Con la instrucción `"# mount"` o `"# df -h"` también podemos comprobar que, efectivamente, tenemos el directorio remoto montado en el sistema local.

> Cualquier cambio en el directorio local será reflejado en el remoto, como si de cualquier otro "montaje" se tratara.

> El montaje remoto no solo se limita al montaje de directorios, permitiendo también el montaje de ficheros (como es obvio)


------------------

[-- Ejercicio 3 --](./ejercicio03.md)
