#!/bin/bash

menu_sshd(){

(yad	--title="SERVICIO DE CONEXION REMOTA" \
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
	sshd_status
	if [[ $status == "ENCENDIO" ]]
	then
		(yad    --text="El servicio de conexion remota esta ACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=100 \
			--height=100 \
		)
		menu_sshd	
	else
		(yad    --text="El servicio de conexion remota esta INACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=100 \
			--height=100 \
		)
		menu_sshd
	fi
		 
elif [[ $ans -eq 1 ]]
then
	service sshd start
	# USO FUNCION sshd_status PARA COMPROBAR QUE SE ENCENDIO EL servicio de conexion remota
	sshd_status
	if [[ $status == "ENCENDIO" ]]
	then
		opc_confirmation=0
		sshd_confirmation
		menu_sshd
	else
		opc_confirmation=1
		sshd_confirmation
		menu_sshd
	fi
elif [[ $ans -eq 2 ]]
then
	service sshd stop
	# USO FUNCION sshd_status PARA COMPROBAR QUE SE DETUVO EL servicio de conexion remota
	sshd_status
	if [[ $status == "DETUVO" ]]
	then
		opc_confirmation=0
		sshd_confirmation
		menu_sshd
	else
		opc_confirmation=1
		sshd_confirmation
		menu_sshd
	fi
else
	exit
fi

}


# FUNCION PARA COMPROBAR SI EL servicio de conexion remota ESTA ACTIVO O INACTIVO
sshd_status(){
status=$(service sshd status | awk '/Active:/ {print $2}')
if [[ $status == "active" ]]
then
        status="ENCENDIO"
else
        status="DETUVO"
fi
}

# FUNCION PARA MOSTRAR CONFIRMACION DE servicio de conexion remota ENCENDIDO O DETENIDO
sshd_confirmation(){
if [[ $opc_confirmation -eq 0 ]]
then
	(yad    --text="El servicio de conexion remota se "$status \
		--timeout=3 \
		--no-buttons \
		--timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
else
	(yad    --text="ERROR: EL servicio de conexion remota NO SE "$status \
	        --timeout=3 \
		--no-buttons \
	        --timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
fi
}

menu_sshd
