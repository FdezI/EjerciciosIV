[-- Ejercicio 1 --](./ejercicio01.md)

----------------------


## Ejercicios 2

### Mostrar los puentes configurados en el sistema operativo.

Para mostrar los puentes configurados en el sistema basta con ejecutar:

    # brctl show

> El paquete bridge-utils proporciona dicho comando.



### Crear un interfaz virtual y asignarlo al interfaz de la tarjeta wifi, si se tiene, o del fijo, si no se tiene.

Crear interfaz de virtual de puente

    # brctl addbr virtual1

Asignarle la tarjeta wifi a la interfaz virtual

    # brctl addif virtual1 wlan0

> Para quitarla: `# brctl delif virtual1 wlan0`


#### Solución a can't add wlan0 to bridge virtual1: Operation not supported

    # iw dev wlan0 set 4addr on
    
> Para desactivarlo: `# iw dev wlan0 set 4addr off`

Esta solución requiere que activemos el modo WDS (Wirless Distributed System) en el router y añadamos la mac del dispositivo a conectarse por razones de seguridad. Aunque muchos routers que no disponen de esta opción por defecto pueden disponer de ella al actualizar su firmware no siempre se puede, por lo que éste nos limite la posibilidad de llevar esta tarea a cabo.

> Funcionamiento: Los paquetes wifi 802.11 envían 3 direcciones mac, la dirección del dispositivo que realiza la conexión, la dirección del AP y la mac del receptor final. Sin embargo, puede cargar con una 4ª dirección mac, la usada en el modo WDS. Esta opción puede ser activada en los sistemas Linux, permitiendo a los dispositivos puente usar este cuarto slot, lo cual trataremos a continuación.

Si nuestro router dispone de esta opción y lo configuramos correctamente la interfaz puente funcionará correctamente pero, por cómo funciona este tipo de conexiones en la mayoría de los casos el router ahora descartará los paquetes de la interfaz puenteada, teniendo que activar/desactivar la 4addr según la interfaz que queramos usar. La solución a esto es crear otra interfaz que utilice la tarjeta wireless asignándole una mac distinta (la cual sería la configurada en el WDS del router) y la cual se asignaría al puente creado anteriormente.

Añadir interfaz:

    # iw dev wlan0 interface add wds0 type managed 4addr on

> Eliminar interfaz:`# iw dev wds0 del`


Modificar mac:

    # ip link set dev wds0 addr 00:11:22:33:44:55

    De esta forma tanto la interfaz puente como la original se conectarían simultáneamente sin problema alguno. No todas las tarjetas wireless soportan tener dos interfaces iniciadas al mismo tiempo, impidiendo esta configuración (siempre es posible tener dos tarjetas wifi).
    

-----------------------

> Fuente: http://nullroute.eu.org/~grawity/journal.html

-------------------------

[-- Ejercicio 3 --](./ejercicio03.md)

-------------------------
