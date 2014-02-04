[-- Ejercicio 9 --](./ejercicio09.md)

------------------

## Ejercicios 10

### Desde un programa en Ruby o en algún otro lenguaje, listar los blobs que hay en un contenedor, crear un fichero con la lista de los mismos y subirla al propio contenedor. Muy meta todo.


El [script](./scripts/list_containers.py), hecho en python, puede [descargarse de aquí](./scripts/list_containers.py) y usará las variables de entorno de azure para autenticarse.

> Serán necesarias las librerías de azure `# pip install azure`. 

```
#! /usr/bin/python

from azure.storage import *
import sys
import os

TMP='/tmp/'



blob_service = BlobService()

containers = blob_service.list_containers()
if len(sys.argv) > 1:
	aux = [container.name for container in containers]
	containers = []
	for arg in sys.argv:
		if arg in aux:
			containers.append(arg)
else:
	containers = [container.name for container in blob_service.list_containers()]

for container in containers:
	print("Container: " + container)
	blobs = blob_service.list_blobs(container)
	count = len(blobs)
	if count > 0:
		blob_name='file_list_' + container
		blob_path=TMP+blob_name
		f = open(blob_path, 'w')
		f.write('Container "%s"(%d):\n' % (container, count))
		for blob in blobs:
			f.write('	%s - %s\n' % (blob.name, blob.url))
		f.close()
		blob_service.put_blob(container, 'FileList', open(blob_path, 'r').read(), x_ms_blob_type='BlockBlob')
		os.remove(blob_path)
```

------------------

[**-- Tema 5 --**](../Tema5)
