#!/bin/bash

menu_mysql(){

(yad	--title="MOTOR" \
	--width=500 \
	--center \
	--text-align=center \
	--text="Que va a realizar:" \
	--button=Estado:0 \
	--button=Encender:1 \
	--button=Apagar:2 \
	--button=Cerrar:3 \
)
ans=$?

if [[ $ans -eq 0 ]]
then		
	mysql_status
	if [[ $status == "ENCENDIO" ]]
	then
		(yad    --text="El motor esta ACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=50 \
			--height=50 \
		)
		menu_mysql	
	else
		(yad    --text="El motor esta INACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=50 \
			--height=50 \
		)
		menu_mysql
	fi
		 
elif [[ $ans -eq 1 ]]
then
	service mysqld start
	# USO FUNCION mysql_status PARA COMPROBAR QUE SE ENCENDIO EL motor
	mysql_status
	if [[ $status == "ENCENDIO" ]]
	then
		opc_confirmation=0
		mysql_confirmation
		menu_mysql
	else
		opc_confirmation=1
		mysql_confirmation
		menu_mysql
	fi
elif [[ $ans -eq 2 ]]
then
	service mysqld stop
	# USO FUNCION mysql_status PARA COMPROBAR QUE SE DETUVO EL motor
	mysql_status
	if [[ $status == "DETUVO" ]]
	then
		opc_confirmation=0
		mysql_confirmation
		menu_mysql
	else
		opc_confirmation=1
		mysql_confirmation
		menu_mysql
	fi
else
	exit
fi

}


# FUNCION PARA COMPROBAR SI EL motor ESTA ACTIVO O INACTIVO
mysql_status(){
status=$(service mysqld status | awk '/Active/ {print $2}')
if [[ $status == "active" ]]
then
        status="ENCENDIO"
else
        status="DETUVO"
fi
}

# FUNCION PARA MOSTRAR CONFIRMACION DE motor ENCENDIO O DETUVO
mysql_confirmation(){
if [[ $opc_confirmation -eq 0 ]]
then
	(yad    --text="El motor se "$status \
		--timeout=3 \
		--no-buttons \
		--timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
else
	(yad    --text="ERROR: EL motor NO SE "$status \
	        --timeout=3 \
		--no-buttons \
	        --timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
fi
}

menu_mysql
