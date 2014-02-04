El primer paso para montar una imagen ISO de forma que únicamente se pueda leer desde un namespace concreto es crear el namespace de montaje:

    # unshare -m /bin/bash

A continuación deberá montarse el disco deseado desde el namespace creado anteriormente:

    # mount disco.iso /mnt/

----------------------------------

[-- Ejercicio 2 --](./ejercicio02.md)
