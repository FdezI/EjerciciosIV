#! /bin/bash

# Autor: Iñaki Fernández Janssens de Varebeke
# e-mail: inakitinajo@gmail.com
# Fecha 01/2014

env_path="$HOME/.juju/environments.yaml"
pem_path="/root/azure.pem"


if [ $UID -ne 0 ]
then
        echo "This script needs Super Cow Powers."
        exit 1
fi




function deploy_charms {
	echo -e "\n\e[90m--- Desplegando paquetes ---\e[00m"
	if [ "$1" == "-x" ]
	then
		echo -e "---> Desplegando \e[34mmysql\e[00m"
		juju deploy mysql 2> /dev/null
		echo -e "---> Desplegando \e[34mmediawiki\e[00m"
		juju deploy mediawiki 2> /dev/null
		echo "     --> Relacionando mediawiki con mysql"
		juju add-relation mediawiki:db mysql 2> /dev/null
		echo "     --> Exponiendo mediawiki"
		juju expose mediawiki
	else
		EXP=0
		M_NUM=""
		for charm in "$@"
		do
			if [ "$charm" == "-e" ]; then EXP=1; continue; fi
			if [ "$charm" -eq "$charm" ] 2> /dev/null; then M_NUM=$charm; continue; fi

			juju get $charm > /dev/null 2> /dev/null
			if [ $? -eq 0 ]
			then
				echo -e "---> \e[34m$charm\e[00m ya desplegado"
			else
				if [ "$M_NUM" != "" ]
				then
					echo -e "---> Desplegando \e[34m$charm\e[00m en máquina \e[34m$M_NUM\e[00m"
					juju deploy --to $M_NUM $charm
					M_NUM=""
				else
					echo -e "---> Desplegando \e[34m$charm\e[00m"
					juju deploy $charm
				fi
			fi


			if [ $EXP -eq 1 ]
			then
				echo "     --> Exponiendo $charm"
				juju expose $charm
			fi
		done
	fi
	
}

function destroy_charms {
	echo -e "\n\e[90m--- Destruyendo servicios ---\e[00m"
	for charm in "${@:2}"
	do
		echo -e "---> Destruyendo servicio \e[34m$charm\e[00m"
		juju destroy-service $charm 2> /dev/null
	done
	sleep 5
}

function show_help {
	echo -e "\n\e[90mOpciones:\e[00m"
	echo -e "    \e[34mSin ninguna opción, los parámetros pasados serán los charms a instalar. Se puede poner la 'máquina' en la que desplegar el 'charm' antes de cada 'charm'"
	echo -e "        \e[32mEj: <script> mysql mediawiki\e[00m\n          Instalaría los 'charms' mysql y mediawiki"
	echo -e "        \e[32mEj: <script> 0 mysql 0 mediawiki\e[00m\n          Instalaría los 'charms' mysql y mediawiki en la máquina 0"
	echo -e "    \e[34m-d <c1, c2, ...>\e[00m: Elimina los 'servicios' c1, c2, ..."
	echo -e "    \e[34m-e <c1, c2, ...>\e[00m: Despliega y expone los 'charms' c1, c2, .... Parámetro tipo 'flag', una vez activado todos los 'servicios' como parámetro pasarán a ser expuestos"
	echo -e "    \e[34m-x\e[00m: Despliega dos 'charms' como ejemplo, mysql y mediawiki, y establece relaciones entre ellos\n\n"
	echo -e "    \e[34mazure\e[00m: Configura el sistema para funcionar con azure (en lugar de local, experimental)\n\n"
}



dpkg -l | grep juju-core > /dev/null
if [ $? -ne 0 ]
then
	# juju install
	echo -e "\n\e[90m--- Instalación de juju ---\e[00m"
	echo "---> Actualizando repositorios"
	sudo add-apt-repository ppa:juju/stable -y
	if [ $? -ne 0 ]
	then
		echo -e "     --> Instalando dependencia para \e[32madd-apt-repository\e[00m"
		sudo apt-get install python-software-properties -y
		sudo add-apt-repository ppa:juju/stable -y
	fi
		
	echo "     --> Actualizando lista de paquetes"
	sudo apt-get update
		
	echo "---> Instalando paquetes"
	echo -e "     --> Instalando \e[32mjuju-core\e[00m"
	sudo apt-get install juju-core -y
	echo -e "     --> Instalando/actualizando \e[32mmongodb-server\e[00m"
	sudo apt-get install mongodb-server -y
		
fi

if [ $# -ne 0 ] && [ "$1" == "-d" ]
then
	destroy_charms $@
else
	if [ $# -ne 0 ] && [ "$1" == "-h" ]; then show_help; exit 0; fi

	# juju init
	echo -e "\n\e[90m--- Inicialización de juju ---\e[00m"
	echo -e "---> Inicializando directorio de configuración"
	juju init 2> /dev/null > /dev/null


	envr="local"
	if [ "$1" == "azure" ];then envr="azure"; fi;
	
	grep "^default: $envr" $env_path > /dev/null
	if [ $? -ne 0 ]	
	then
		echo -e "---> Estableciendo entorno \e[35m$envr por defecto\e[00m"
		sed -i 0,/"default:"/{s/"default:.*"/"#default: amazon\ndefault: $envr"/} $env_path
	fi


	echo -e "---> Cambiando a entorno \e[32m$envr\e[00m"
	juju switch $envr > /dev/null
	if [ $? -ne 0 ]; then echo "\e[91mError al cambiar de entorno"; exit 1; fi

	if [ "$1" == "azure" ]
	then
		echo -e "\n\e[90m--- Administrando certificados ---\e[00m"
		"---> Creando certificados"
		openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout $pem_path -out $pem_path
		openssl x509 -inform pem -in $pem_path -outform der -out $HOME/azure.cer
		chmod 600 /root/azure.pem

		"---> Configurando juju"
		azurel=`grep -n "azure" ~/.juju/environments.yaml | head -1 | cut -d':' -f 1`
		sed -i $azurel,/"management-subscription-id:"/{s/"management-subscription-id:.*"/"management-subscription-id: `azure account list | tail -1 | cut -d' ' -f7`"/} $env_path
		sed -i $azurel,/"management-certificate-path:"/{s/"management-certificate-path:.*"/"management-certificate-path: $pem_path"/} $env_path
		sed -i $azurel,/"storage-account-name:"/{s/"storage-account-name:.*"/"storage-account-name: `azure storage account list | grep "data" | tail -1 | cut -d' ' -f 5`"/} $env_path
		echo -e "\e[31;1m---> 1. Ingrese en \e[35;1mhttps://manage.windowsazure.com\e[31;1m y suba el certificado \e[36;1m$HOME/azure.cer\e[31;1m a la sección de Configuración -> Certificados de administración -> Cargar\e[00m"
		echo -e "\e[31;1m---> 2. Elimine el certificado \e[36;1m$HOME/azure.cer\e[00m"
	fi;

	echo -e "\n\e[90m--- Iniciando Entorno ---\e[00m"
	echo "---> Creando taper"
	sudo juju bootstrap 2> /dev/null
	ps ax | grep -i [m]ongod > /dev/null
	if [ $? -ne 0 ]
	then
		echo "     --> Base de datos posiblemente desactualizada, comprobando"
		if [ `ls /etc/init/juju-* | wc -l` -lt 2 ]
		then
			sudo apt-get update
			sudo apt-get install mongodb-server -y
			juju destroy-enviroment -y
		fi

		echo "    --> Reintentando taper"
		sudo juju bootstrap
		if [ $? -ne 0 ]; then echo "\e[91mError al crear taper"; exit 1; fi
	fi

	if [ $# -eq 0 ]
	then
		show_help
	else
		if [ "$1" != "azure" ]; then deploy_charms $@; fi
	fi
fi
