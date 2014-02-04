[-- Ejercicio 2 --](./ejercicio2.md)

--------------------------------


## Ejercicios 3

### ¿Qué tipo de virtualización usarías en cada caso?

* **Alojar varios clientes en un solo servidor:** virtualización plena debido a que los componentes del servidor serán utilizados por cada cliente de forma aislada.
* **Crear un sistema eficiente de web + middleware + base datos:** virtualización a nivel de aplicaciones, empaquetando el software aislándolo e independizándolo, permitiendo una mayor eficiencia.
* **Sistema de prueba de software e integración continua:** Para este caso, la opción más adecuada sería la llamada virtualización de entornos de desarrollo puesto que permite reproducir de la forma más fiel posible el posterior entorno de producción.


### Crear un programa simple en cualquier lenguaje interpretado para Linux, empaquetarlo con CDE y probarlo en diferentes distribuciones

El primer paso será instalar el programa cde, esto puede realizarse de dirversas formas:
* Instalarlo desde los repositorios (si disponible):

    # apt-get install cde

* Descargarlo desde git y compilarlo:

    # git clone git://github.com/pgbovine/CDE.git
    # cd CDE
    # make
    # make install

A continuación empaquetaremos un script hecho en Bash (~/Scripts/lsust) con cde:
    $ cde bash [~/Scripts/lsust](./scripts/lsust.sh)

Una vez realizado este paso el paquete estará listo para ser ejecutado en cualquier entorno. Para ello deberemos localizar el “paquete” generado, normalmente bajo la carpeta en la que se está trabajando (“$ pwd”) en una carpeta nombrada “cde-package”. Esta carpeta contiene, entre otros, un ejecutable “cde-exec” y un directorio (cde-root) emulando nuestro sistema de directorios desde el root (/) hasta el script que hemos ejecutado previamente y que querremos ejecutar. Para ejecutar este script en el entorno aislado creado con cde deberemos localizar el script dentro del paquete y ejecutar el fichero que se encuentra en su mismo directorio llamado de la misma forma pero con la extensión “.cde” (de esta forma, aunque el sistema no disponga de la aplicación usada para ejecutar dicho script, en este caso Bash, el programa siga funcionando:

    $ cd cde-package/cde-root/home/inaki/Scripts/
    $ ./lsust.cde

De esta forma ya tenemos comprobado que funciona correctamente, pero para ejecutar el programa en el mismo sistema no necesitamos realizar este empaquetamiento sino para ejecutarlo en sistemas distintos, para ello deberemos transportar el paquete y la mejor forma es “empaquetándolo” y comprimiéndolo en cualquier formato diseñado para este fin, por ejemplo:
    $ tar -zcvf cde-lsust.tgz cde-package/

> Se puede encontrar un manual básico en: http://www.pgbovine.net/cde/manual/basic-usage.html


-------------------------------

[-- Ejercicio 4 --](./ejercicio4.md)
