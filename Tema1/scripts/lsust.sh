#!/bin/bash

	# Nombre: lsust
	# Autor: Iñaki Fdez
	# Año: 2007
	# Licencia: GPLv2

	# El proposito de este script es de automatizar el renombre de ficheros
	# mediante la sustitución de cadenas

	# Para ello se utiliza el comando "ls"(lectura de contenido de directorios),
	# el comando "sed"(sustitución de cadenas) y el comando "mv" (mover ficheros/directorios)

	# Tener en cuenta que la redundancia de código presente, aunque pueda molestar a la lectura
	# y comprendimiento del script, se ha dejado a cambio de un mayor rendimiento



# Variable de inicialización de bucle (desactivada)
ENTER=0

# Variable que va a guardar la fecha (formato: "dia-mes-año")
FECHA=`date +%d-%m-%y`

# Variable de comparación de cambios realizados
Y=`ls`

##### Comprobacion de parámetros Y Realización del renombrado #####

### Si no se introduce ninguno

if ! [ -d ~/.lsust ]
then
	mkdir ~/.lsust
fi

if ! [ -f ~/.lsust/access.log ]
then
	echo -e "HISTORIAL DE RENOMBRES LLEVADOS A CABO\n" > ~/.lsust/access.log
fi

if ! [ -f ~/.lsust/ayuda ]
then
	echo "---------------------------------- Ayuda ----------------------------------" > ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   NOMBRE:      lsust                                                    |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   DESCRIPCIÓN: Comando para facilitar el renombre todos los             |" >> ~/.lsust/ayuda
	echo "|                ficheros y subdirectorios de un directorio               |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   SINTAXIS:        lsust [opcion]                                       |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                Se debe tener en cuenta que renombrará todos los         |" >> ~/.lsust/ayuda
	echo "|                los ficheros y subdirectorios dentro del directorio (si  |" >> ~/.lsust/ayuda
	echo "|                se especifica el parámetro "-d") en el que se ejecute    |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   OPCIONES:                                                             |" >> ~/.lsust/ayuda
	echo "|                Si no se especifica opción, saltará un menú con todas    |" >> ~/.lsust/ayuda
	echo "|                las opciones                                             |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -b, --blank                                              |" >> ~/.lsust/ayuda
	echo "|                       sustituye todos los espacios en blanco por el     |" >> ~/.lsust/ayuda
	echo "|                       caracter "_"                                      |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -d, --directory                                          |" >> ~/.lsust/ayuda
	echo "|                       Incluye renombre de directorios                   |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -h, --ayuda                                              |" >> ~/.lsust/ayuda
	echo "|                       muestra ayuda acerca del comando                  |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -s, --select-string                                      |" >> ~/.lsust/ayuda
	echo "|                       realiza una petición acerca de la cadena de texto |" >> ~/.lsust/ayuda
	echo "|                       a sustituir y otra por la que sustituir           |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -rm, --remove                                            |" >> ~/.lsust/ayuda
	echo "|                       elimina la parte del nombre que deseemos          |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                -R, --recursive (aun no implementado)                    |" >> ~/.lsust/ayuda
	echo "|                       renombra de forma recursiva                       |" >> ~/.lsust/ayuda
        echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   FICHEROS:                                                             |" >> ~/.lsust/ayuda
	echo "|                ~/.lsust/access.log                                      |" >> ~/.lsust/ayuda
	echo "|                       log en el cual se registran los cambios           |" >> ~/.lsust/ayuda
	echo "|                       realizados                                        |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                ~/.lsust/error.log                                       |" >> ~/.lsust/ayuda
	echo "|                       log en el cual se registran los errores           |" >> ~/.lsust/ayuda
	echo "|                       encontrados                                       |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|                ~/.lsust/ayuda                                           |" >> ~/.lsust/ayuda
	echo "|                       fichero en el que se encuentra esta ayuda         |" >> ~/.lsust/ayuda
	echo "|   AUTOR:                                                                |" >> ~/.lsust/ayuda
	echo "|                Iñaki Fernández Janssens de Varebeke                     |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   BUGS:                                                                 |" >> ~/.lsust/ayuda
	echo "|               Si encuentra algún bug en la ejecución del script,        |" >> ~/.lsust/ayuda
	echo "|               comuniquemelo personalmente a la dirección de correo      |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   CONTACTO:                                                             |" >> ~/.lsust/ayuda
	echo "|               inaki_tinajo@hotmail.com                                  |" >> ~/.lsust/ayuda
	echo "|               Cualquier consejo/sugerencia para la mejora del script    |" >> ~/.lsust/ayuda
	echo "|               es bien recibida                                          |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "|   VERSIÓN:     0.98b                                                    |" >> ~/.lsust/ayuda
	echo "|                                                                         |" >> ~/.lsust/ayuda
	echo "---------------------------------------------------------------------------" >> ~/.lsust/ayuda
fi

if [ $# -eq 0 ]
then
	MENU=0
	while [ $MENU -eq 0 ]
	do
		clear
		echo "                                  ----- Menú (lsust) -----                  "
		echo
		echo "               1. Sustituir espacios en blanco por '_'                      "
		echo "               2. Sustituir espacios en blanco por '_' (incluir directorios)"
		echo
		echo "               3. Pedir cadenas por y a sustituir                           "
		echo "               4. Pedir cadenas por y a sustituir (incluir directorios)     "
		echo
		echo "               5. Historiales                                               "
		echo
		echo "               6. Limpieza                                                  "
		echo
		echo "               7. Destruir parte de la cadena                               "
		echo "               8. Sustituir desde/hasta caracter                            "
		echo
		echo "               0. Mostrar Ayuda                                             "
		echo
		echo "               9. Salir                                                     "
		read -p "Seleccione una opción: " OPCION

		if [ "$OPCION" = "9" ]
		then exit

		elif [ "$OPCION" = "0" ]
		then less ~/.lsust/ayuda

		elif [ "$OPCION" = "5" ]
		then
			clear
			echo "                                  ----- Historiales -----                   "
			echo
			echo "               1. Mostrar historial de renombres llevados a cabo (éxitos)   "
			echo "               2. Mostrar historial de problemas encontrados (errores)      "
			echo
			echo "               0. Mostrar ayuda                                             "
			echo
			echo "               9. Salir                                                     "
			read -p "Seleccione una opción: " OPCION2

			if [ "$OPCION2" = "1" ]
			then less ~/.lsust/access.log

			elif [ "$OPCION2" = "2" ]
			then less ~/.lsust/error.log
			
			fi

		elif [ "$OPCION" = "6" ]
		then
			clear
			echo "                                   ----- Eliminado -----                    "
			echo
			echo "               1. Eliminar historial de éxitos (access.log)                 "
			echo "               2. Eliminar historial de errores (error.log)                 "
			echo
			echo "               3. Eliminar fichero de ayuda                                 "
			echo
			echo "               4. Eliminar directorio completo del comando 'lsust'          "
			echo
			echo "               0. Mostrar ayuda                                             "
			echo
			echo "               9. Salir                                                     "
			read -p "Seleccione una opción: " OPCION2

			if [ "$OPCION2" = "1" ]
			then read -p "¿Está seguro/a de querer eliminar el fichero access.log? [Si/No]: " DECISION
				if [ "$DECISION" = "Si" ]
				then rm ~/.lsust/access.log
				fi

			elif [ "$OPCION2" = "2" ]
			then read -p "¿Está seguro/a de querer eliminar el fichero error.log? [Si/No]: " DECISION
				if [ "$DECISION" = "Si" ]
				then rm ~/.lsust/error.log
				fi

			elif [ "$OPCION2" = "3" ]
			then read -p "¿Está seguro/a de querer eliminar el fichero ayuda? [Si/No]: " DECISION
				if [ "$DECISION" = "Si" ]
				then rm ~/.lsust/ayuda
				fi

			elif [ "$OPCION2" = "4" ]
			then read -p "¿Está seguro/a de querer eliminar el directorio completo de lsust? [Si/No]: " DECISION
				if [ "$DECISION" = "Si" ]
				then rm -rf ~/.lsust
				fi
			fi

		elif [ "$OPCION" != "" ]
		then
			MENU=1
		fi

			if [ "$OPCION2" = "9" ]
			then exit

			elif [ "$OPCION2" = "0" ]
			then less ~/.lsust/ayuda
			fi
	done
fi

if [ "$1" = "-b" ] || [ "$1" = "--blank" ] || [ "$1" = "-d" ] || [ "$1" = "--directory" ] || [ "$OPCION" = "1" ] || [ "$OPCION" = "2" ]
then
	echo Realizando cambios...
	cat ~/.lsust/access.log | grep Historial | grep $FECHA 1> /dev/null
	if [ $? -eq 1 ]
		then
			echo -e "\n\nHistorial $FECHA:\n" >> ~/.lsust/access.log
	fi
		

	for I in `ls | sed 's/ /_caracter_espacio_/g'`	# Bucle aparte del principal, con el cual sustituimos todos los espacios
	do							#en blanco por "_". Se aparta el bucle por problemas con el comando "sed
		I=`echo $I | sed 's/_caracter_espacio_/ /g'`
		N=`echo $I | sed 's/ /_/g' | tr -s "_"`		#[tr -s "_"]<--- Además, se eliminan los "_" repetidos ("___" --> "_")

		if [ "$I" != "$N" ]
		then
			if [ -f "$I" ]
			then
				if ! [ -f "$N" ]
				then
					mv "$I" "$N" 2> /dev/null
					echo "  (f)     `pwd`/$I        -->     `pwd`/$N" >> ~/.lsust/access.log
				else
					 echo "[$FECHA] - (f)  `pwd`/$I        -->     `pwd`/$N        error: $N ya existe" >> ~/.lsust/error.log
				fi

			elif [ "$1" = "-d" ] || [ "$1" = "--directory" ] || [ "$OPCION" = "2" ]
			then if [ -d "$I" ]
			then
				if ! [ -d "$N" ]
				then
					mv "$I" "$N" 2> /dev/null
					echo "  (d)     `pwd`/$I        -->     `pwd`/$N" >> ~/.lsust/access.log
				else
					echo "[$FECHA] - (d)  `pwd`/$I        -->     `pwd`/$N        error: $N ya existe" >> ~/.lsust/error.log
				fi
			fi
			fi
		fi
	done

	ENTER=0		# Desactivación de la variable de iniciacion de bucle

### Si se encuentran parámetros:
## Si el parámetro es "-m" o "--menu"
# Petición de caracteres a sustituir y los sustitutos
elif [ "$1" = "-s" ] || [ "$1" = "--select-string" ] || [ "$OPCION" = "3" ] || [ "$OPCION" = "4" ]
then
	ENTER=1
	read -p "Cadena a sustituir: " CARACTER1
	read -p "Cadena por la que sustituir: " CARACTER2


## Si el parámetro es "-h" o "--help"
# Mostrado de ayuda acerca del comando 'lsust'
elif [ "$1" = "-h" ] || [ "$1" = "--help" ]
then less ~/.lsust/ayuda




######## Eliminar parte de la cadena
elif [ "$OPCION" = "7" ] || [ "$1" = "-rm" ] || [ "$1" = "--remove" ]
then
	ENTER=1
	OPCION="77"
	read -p "Cadena a eliminar: " STRDEL
	echo Funcion en construccion!


### En caso de que el parámetro no sea correcto
else
	echo Parámetros incorrectos
	ENTER=0		# Desactivación de la variable de iniciación de bucle
fi


# Inicialización del bucle (Si la variable ENTER está activada)
if [ $ENTER -eq 1 ]
then
	echo Realizando cambios...
	echo -e "\n\nHistorial $FECHA:\n" >> ~/.lsust/access.log
	for I in `ls | sed 's/ /_caracter_espacio_/g'`  # Bucle principal, en el cual, dependiendo de la funcion elegida, realizará
	do                                                      #una acción u otra
		if [ "$OPCION" = "77" ] # Eliminar parte del nombre
		then

			NUMC=`echo $I | wc -m` # Numero de caractereres
			NUMC=`expr $NUMC - 1` # Rectificacion del numero de caracteres ya que wc cuenta uno de mas

			LETRA=1
			SIZE=0
			ROMPER=0
			for C in `seq $NUMC` # Recorriendo cadena caracter por caracter
			do
				if [ `echo $I | cut -c $C` = `echo $STRDEL | cut -c $LETRA` ] 2> /dev/null
				then
					ROMPER=1
					if [ $LETRA -eq 1 ]
					then
						INICIOCORTE=`expr $C - 1` # Aqui empieza el corte
						SIZE=1
					elif [ `expr $CANTERIOR + 1` -eq $C ]
					then
						SIZE=`expr $SIZE + 1` # Tamanyo del corte, va aumentando
					else
						break
					fi

					LETRA=`expr $LETRA + 1`
					CANTERIOR=$C

				elif [ $ROMPER -eq 1 ]
				then
					break
				fi
			done
			LENSTRDEL=`echo $STRDEL | wc -m`
			LENSTRDEL=`expr $LENSTRDEL - 1`
			if [ $SIZE -eq $LENSTRDEL ]
			then
				STRLEN=`echo $I | wc -m`
				N=${I:0:$INICIOCORTE}${I:`expr $C - 1`:$NUMC} # Palabra resultante despues del corte
			fi

		else

			# Cambiando "[" por "______", y el "." por "++++++" por compatibilidad con el comando sed y volcando a ficheros temporales
			echo $CARACTER1 | sed 's/'\\['/'______'/g' | sed 's/'\\.'/'++++++'/g' > .temp_1   # Modificando la primera cadena
			echo $CARACTER2 | sed 's/'\\['/'______'/g' | sed 's/'\\.'/'++++++'/g'> .temp_2   # Modificando la segunda cadena

			CARACTER1=`cat .temp_1`
			CARACTER2=`cat .temp_2`

			echo $I | sed 's/'\\['/'______'/g' | sed 's/'\\.'/'++++++'/g' | sed 's/'$CARACTER1'/'$CARACTER2'/g' | sed 's/'______'/'\\['/g' | sed 's/'++++++'/'\\.'/g' > .temp_3
						#|-> Modificando el nombre final, y reponiendo los caracteres "[" y "."

			I=`echo $I | sed 's/_caracter_espacio_/ /g'`
			N=`cat .temp_3`
		fi

		## Funcion a realizar comun (mover ficheros)
		if [ "$I" != "$N" ]
		then
			if [ -f "$I" ]
			then
				if ! [ -f "$N" ]
				then 
					mv "$I" "$N" 2> /dev/null
					echo "  (f)     `pwd`/$I        -->     `pwd`/$N" >> ~/.lsust/access.log
				else
					echo "[$FECHA] - (f)  `pwd`/$I        -->     `pwd`/$N        error: $N ya existe" >> ~/.lsust/error.log
				fi

			## Incluir directorios
			elif [ "$2" = "-d" ] || [ "$2" = "--directory" ] || [ "$OPCION" = "4" ]
			then if [ -d "$I" ]
			then
				if ! [ -d "$N" ]
				then 
					mv "$I" "$N" 2> /dev/null
					echo "  (d)     `pwd`/$I        -->     `pwd`/$N" >> ~/.lsust/access.log
				else
					echo "[$FECHA] - (d)  `pwd`/$I        -->     `pwd`/$N        error: $N ya existe" >> ~/.lsust/error.log
				fi
			fi
			fi
		fi
	done
fi

# Eliminamos ficheros temporales
#echo Eliminando ficheros temporales...
#rm .temp_1 .temp_2 .temp_3 2> /dev/null

# Comprobación final de resultados
Z=`ls`
if  [ "$1" != "-h" ] && [ "$1" != "--help" ] && [ "$OPCION" != "0" ]
then
        if [ "$Y" = "$Z" ]                                              # Comparación del resultado de "ls" antes y después
        then                                                            # para saber si se ha efectuado algún cambio
		echo -e "\033[1m[\033[0m"'\E[37;31m'"\033[1iNo se ha realizado ningún cambio!!!\033[0m""\033[1m]\033[0m"
        else
		echo -e "\033[1m[\033[0m"'\E[37;32m'"\033[1iCambios realizados con éxito!\033[0m""\033[1m]\033[0m"
        fi
fi
