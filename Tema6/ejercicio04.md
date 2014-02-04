[-- Ejercicio 3 --](./ejercicio03.md)

------------------

## Ejercicios 4

### Desplegar los fuentes de la aplicación de DAI o cualquier otra aplicación que se encuentre en un servidor git público en la máquina virtual Azure (o una máquina virtual local) usando ansible.

Formas de instalar
* Como módulo:

        # apt-get install python-pip
        # pip install ansible


* Como aplicación:

        # apt-get install ansible
    > Disponible en los "backports/universe" de ubuntu o en `ppa:rquillo/ansible`


Añadimos nuestro host (vmej5.cloudapp.net) al fichero de hosts:

    # echo -e "[azure]\nvmej5.cloudapp.net" >> /etc/ansible/hosts

> En caso de querer usar un fichero de configuración distinto al "/etc/ansible/hosts" habrá que especificar la ruta de dicho fichero con la variable de entorno "ANSIBLE_HOSTS".


Comprobamos:

    # ansible azure -u melki -m ping --ask-pass 

> Se necesita la aplicación sshpass: `# apt-get install sshpass`.

* Si se quiere trabajar sin tener que introducir contraseñas constantemente, siempre se puede copiar nuestra llave pública de ssh al host:

        $ ssh-copy-id melki@vmej5.cloudapp.net

    > De esta forma tendremos acceso ssh sin necesidad de poner manualmente una contraseña: `$ ansible azure -u melki -m ping`


Desplegamos los fuentes:

    $ ansible azure -u melki -m git -a "repo=https://github.com/FdezI/Practica2.git dest=~/pr2_iv_dai"

> Si nos muestra el error "Failed to find required executable git" es debido a que la máquina 	remota no tiene git instalado:

    $ ansible azure -u melki -m apt -a "pkg=git"

Comprobamos:

    [vmej5]$ tree ~/pr2_iv_dai


------------------

[-- Ejercicio 5 --](./ejercicio05.md)
