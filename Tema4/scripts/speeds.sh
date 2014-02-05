#!/bin/bash

# Autor: Iñaki Fernández Janssens de Varebeke
# e-mail: inakitinajo@gmail.com
# Fecha 01/2014
# Licencia: GPLv2

### Datos
# Tamaño de imágenes (en GB)
SIZE=1

# Localización de imágenes (pwd=actual)
LOCATION="`pwd`"

# Formatos a comparar
FSs="xfs btrfs ntfs ext4"

# Directorio principal de montaje
MNT="/mnt"

# Ruta de fichero para los tests
testfile="/tmp/testfile"

# Tamaño de fichero de tests (en KB)
tfSIZE=524288


LOOPS=""
ToCreate=""
steps=$1

if [ $UID -ne 0 ]
then
	echo "This script needs Super Cow Powers."
	exit 1
fi

if [ $# -ne 1 ]
then
	echo -e "\n\e[90mUso: \e[32m<script> <pasos>\e[00m"
	echo -e "\e[36mEditar variables en cabecera para personalizar\e[00m\n"
	exit 0
fi

AUX="`losetup -a`"
if [ "$AUX" != "" ]
then
	echo -e "\n\e[90m--- Dispositivos loop ocupados ---\e[00m"
	losetup -a
	read -p "¿Desea desmontar estos dispositivos antes de proseguir? [y/N]: " AUX
	if [ "$AUX" == "y" ]  || [ "$AUX" == "Y" ]
	then
		echo -e "---> Desmontando dispositivos"
		for LOOP in "`losetup -a | cut -d':' -f1`"
		do
			umount $LOOP 2> /dev/null
			losetup -d $LOOP
		done
	fi

	if [ $(expr 8 - `losetup -a | wc -l`) -lt `echo $FSs | wc -w` ]
	then
		echo -e "\e[31mNO HAY SUFIENTES DISPOSITIVOS LOOP DISPONIBLES\e[00m"
		exit 1
	fi
	
fi

echo -e "\n\e[90m--- Comprobando dependencias ---\e[00m"
for fs in `echo $FSs`
do
	FAIL=0
	whatis mkfs.$fs 2> /dev/null > /dev/null
	if [ $? == 0 ]; then
		echo -e "---> mkfs.$fs		\e[90m[\e[92mOK\e[90m]\e[00m"
	else
		echo -e "---> mkfs.$fs           \e[90m[\e[91m-\e[90m]\e[00m"
		FAIL=1
	fi

	if [ $FAIL -eq 1 ]
	then
		echo -e "\nFaltan depencias, se sale del script"
		exit 1
		# Falta añadir auto resolutor de dependencias
	fi
done


echo -e "\n\e[90m--- Comprobando imágenes ---\e[00m"
for fs in `echo $FSs`
do
	if [ -f "$fs.img" ]; then
		echo -e "---> $fs.img		\e[90m[\e[92mOK\e[90m]\e[00m"
	else
		echo -e "---> $fs.img           \e[90m[\e[91m-\e[90m]\e[00m"
		ToCreate="`echo $ToCreate $fs`"
	fi
done

AUX=""
if [ "$ToCreate" != "" ]
then
	echo $ToCreate
	read -p "¿Crear imágenes en $LOCATION? [y/N]: " AUX
	if [ "$AUX" != "y" ]  && [ "$AUX" != "Y" ]; then exit 1; fi
fi



echo -e "\n\e[90m--- Tratando imágenes ---\e[00m"
for fs in `echo $FSs`
do
	imagen="$LOCATION/$fs.img"
	echo -e "---> Tratando imagen \e[34m$imagen\e[00m"

	if [ "`echo $ToCreate | grep $fs`" != "" ]
	then
		echo "     --> Creando imagen"
		qemu-img create -f raw $imagen ${SIZE}G > /dev/null
	fi

	echo "     --> Convirtiendo en dispositivo loop"
	LOOP="`losetup -v -f $imagen | cut -d' ' -f4`"
	if [ "`echo $LOOP | grep already`" != "" ]; then  LOOP="`losetup -a | grep "$fs" | head -1 | cut -d':' -f1`"; fi

	if [ "`echo $ToCreate | grep $fs`" != "" ]
	then
		echo "     --> Formateando imagen"
		if [ "$fs" == "ntfs" ]; then mkfs.ntfs -f $LOOP > /dev/null
		else mkfs.$fs $LOOP > /dev/null; fi
	fi

	echo "     --> Creando punto de montaje"
	mkdir -p "$MNT/$fs"

	echo "     --> Montando dispositivo $LOOP en $MNT/$fs"
	mount $LOOP "$MNT/$fs"

	LOOPS=`echo $LOOPS $LOOP`
done
echo -e "\e[32mImagenes montadas en $MNT/\e[00m"


if [ -f $testfile ]; then echo -e "\n\e[90m--- Usando fichero \e[34m$testfile\e[90m para tests ---\e[00m"
else
	echo -e "\n\e[90m--- Creando fichero \e[34m$testfile\e[90m para tests ---\e[00m"
	dd if=/dev/urandom of=$testfile bs=1k count=$tfSIZE > /dev/null
fi

for fs in `echo $FSs`
do
	declare "W_$fs=0"
	declare "L_$fs=0"
done

W_OVER=0
L_OVER=0
testfiletmp="/tmp/$(basename $testfile)2"
echo -e "\n\e[90m--- Iniciando tests ---\e[00m"
echo "     --> Velocidad de escritura"
echo -n "         -> Pasada "
for I in `seq $steps`
do

	
	echo -ne "\e[34m$I\e[00m."
	for fs in `echo $FSs`
	do
		varname="W_$fs"
		
		declare "W_$fs=$(echo `/usr/bin/time -f %e cp $testfile /mnt/xfs/ 2>&1 1>/dev/null` + ${!varname} | bc -l)"
		echo -n .
	done

	W_OVER=$(echo `/usr/bin/time -f %e cp $testfile $testfiletmp 2>&1 1>/dev/null` + $W_OVER | bc -l)
done

echo -e "\n     --> Velocidades de lectura"
echo -n "         -> Pasada "
for I in `seq $steps`
do
	echo -ne "\e[34m$I\e[00m."
	for fs in `echo $FSs`
	do
		varname="L_$fs"

		declare "L_$fs=$(echo `/usr/bin/time -f %e cp /mnt/xfs/$(basename $testfile) /dev/null 2>&1 1>/dev/null` + ${!varname} | bc -l)"
		echo -n .
	done

	L_OVER=$(echo `/usr/bin/time -f %e cp $testfile /dev/null 2>&1 1>/dev/null` + $L_OVER | bc -l)

done

### MOSTRANDO TIEMPOS ###
function round {
	printf %.1f `echo $1 | bc -l`
}
# Lectura
echo -e "\n\e[32mTiempos (\e[34mlectura):\e[00m"
for fs in `echo $FSs`
do
	varname="L_$fs"
	echo -e "\e[33m$fs:\e[00m `round "${!varname} / $steps"`s"
done
echo -e "\e[33m\"EXT4\"(Mismo sistema, sin Overhead):\e[00m `round "$L_OVER / $steps"`s"


# Escritura
echo -e "\n\e[32mTiempos (\e[34mEscritura):\e[00m"
for fs in `echo $FSs`
do
	varname="W_$fs"
	echo -e "\e[33m$fs:\e[00m `round "${!varname} / $steps"`s"
done
echo -e "\e[33m\"EXT4\"(Mismo sistema, sin Overhead):\e[00m `round "$W_OVER / $steps"`s"


### LIMPIANDO ###
echo -e "\n\e[90m--- Limpiando ---\e[00m"
echo "---> Desmontando dispositivos"
for LOOP in $LOOPS
do
	umount -f $LOOP
done

echo "---> Eliminando temporales"
rm $testfiletmp

read -p "---> ¿Desea eliminar el fichero de tests? [Y/n]: " AUX
if [ "$AUX" != "n" ]  && [ "$AUX" != "N" ]
then
	echo -e "     --> Eliminando fichero \e[34m$testfile\e[00m"
	rm $testfile
fi

# No se pone junto con el umount para darle tiempo a desmontar (ntfs, por ejemplo, tarda un poco)
echo "---> Eliminando dispositvos loop"
for LOOP in $LOOPS
do
	losetup -d $LOOP
done

read -p "---> ¿Desea eliminar las imágenes de las pruebas? [y/N]: " AUX
if [ "$AUX" != "y" ]  && [ "$AUX" != "Y" ]
then
	echo "     --> Eliminando imágenes"

	for fs in `echo $FSs`
	do
		imagen="$LOCATION/$fs.img"
		echo -e "        -> Eliminando \e[34m$imagen\e[00m"
		rm $imagen
	done
fi
