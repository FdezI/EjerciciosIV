[-- Ejercicio 5 --](./ejercicio05.md)

------------------

## Ejercicios 6

### Usar juju para hacer el ejercicio anterior.

Para hacer el ejercicio anterior pero con juju deberemos, como no, instalar juju en nuestro sistema:

    # apt-get install juju-core
    $ juju init

Antes de configurar juju crearemos los certificados ssl:

    $ openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout azure.pem -out azure.pem
    $ openssl x509 -inform pem -in azure.pem -outform der -out azure.cer
    $ chmod 600 azure.pem

A continuación se deberá modificar el fichero de configuración de juju **"~/.juju/environments.yaml"** (En caso de no tener este fichero: `$ juju generate-config`) añadiéndole los parámetros de autenticación:
* **management-susbscription-id**: visible con `$ azure account list`

* **management-certificate-path**: ruta del fichero "azure.pem" creado anteriormente.

* **storage-account-name**: visible con `$ azure storage account list`

Subimos el certificado a **azure** (únicamente posible mediante su interfaz web) accediendo a **Configuración → Certificados de administración → Cargar** y seleccionando el ".cert" creado anteriormente.

Una vez configurado activamos el entorno con:

    $ juju switch azure
	(Es recomendable poner éste por defecto, bajo el parámetro `default: azure` del fichero 	"~/.juju/environments.yaml")

y desplegamos y exponemos la interfaz web de juju:

    $ juju deploy --to 0 juju-gui
    $ juju expose juju-gui

> Tras unos segundos tendremos lista la interfaz web de juju (para ver la dirección de acceso: `$ juju status`) a la cual podremos loguearnos usando la clave disponible en el parámetro "admin-secret" del fichero "~/.juju/invironments.yaml")

Mediante la interfaz web buscamos "nginx" e instalamos el 'charm' correspondiente. Veremos que en un inicio está en pending (amarillo), lo cual significa que está intentando arrancar. Curiosamente, si se tiene una suscripción "mala" de azure, tal y como es la nuestra, estará en "pending" hasta el final de los días (puede verse el error con `$ juju status` en la máquina 1) al intentar ejecutarse en una segunda máquina virtual, por ello deberemos "migrar" el servicio a nuestra máquina 0 (añadimos una "unidad" de servicio en la máquina 0 y eliminamos la unidad perteneciente a la máquina 1):

    $ juju add-unit --to 0 nginx
    $ juju destroy-unit nginx/0
    $ juju destroy-machine 1


------------------

> El [script del tema 3, autojuju.sh](../Tema3/autojuju.sh), junto con el parámetro **azure**, instalará juju, y lo configurará (creando, incluso, los certificados) automáticamente.

------------------

> Documentación: https://juju.ubuntu.com/docs/config-azure.html

------------------

[-- Ejercicio 7 --](./ejercicio07.md)
