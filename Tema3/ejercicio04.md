[-- Ejercicio 3 --](./ejercicio03.md)

---------------------


## Ejercicios 4

### Instalar lxc-webpanel y usarlo para arrancar, parar y visualizar las máquinas virtuales que se tengan instaladas.

    # wget http://lxc-webpanel.github.io/tools/install.sh -O - | bash

* Si la instalación se completa **exitosamente**, mostrando: * **Installation complete!** * pero el web panel no es accesible lo más seguro es que falte alguna dependencia. Para ver de qué se trata no está de más prestar atención al proceso de instalación, en el cual seguramente veamos la dependencia faltante, en este caso `python-pip`. Éste puede ser instalado:

        # apt-get install python-pip

    > En caso de no disponer de éste en los repositorios: `# apt-get install python-setuptools && easy_install pip`

    > Volvemos a instalar el web panel (para ello eliminamos primero el directorio de instalación: `# rm -rf /srv/lwp/`


### Desde el panel restringir los recursos que pueden usar: CPU shares, CPUs que se pueden usar (en sistemas multinúcleo) o cantidad de memoria.

En el panel principal, como podemos ver, se pueden ejecutar tres acciones distintas sobre las máquinas virtuales: "Start", "Stop" y "Freeze":

* **Start**: Iniciar la máquina (uso de CPU + RAM)
* **Stop**: Detener la máquina (Sin uso)
* **Freeze**: Congelar la máquina (Uso de RAM)

Si seleccionamos alguna de las máquinas (bien en el panel lateral, bien clickando sobre el nombre de la misma en el "Overview") nos permitirá restringir/limitar algunos de los recursos que usa dicha máquina (cpu, compartición de cpu, memoria, datos de red, etc). En el siguiente ejemplo se le permitirá usar únicamente las CPUs 0 y 1, 256MB de memoria RAM y un total de 2048MB de memoria virtual (RAM + SWAP). Dejaremos los datos de red y el límite de compartición de cpu como están.

A la hora de realizar el cambio debemos asegurarnos de que la máquina se encuentre detenida (**"Status"** arriba a la derecha) antes de aplicar, de lo contrario soltará un **"Internal server error"**.

Si los cambios son aplicados correctamente podrá verse algo parecido a lo siguiente:

---------------------

> Más detalles: https://help.ubuntu.com/lts/serverguide/lxc.html

---------------------

[-- Ejercicio 5 --](./ejercicio05.md)
