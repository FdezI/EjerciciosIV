#! /usr/bin/python

# Autor: Iñaki Fernández Janssens de Varebeke
# e-mail: inakitinajo@gmail.com
# Fecha 01/2014
# Licencia: GPLv2


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

