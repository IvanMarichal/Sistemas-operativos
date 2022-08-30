#!/bin/bash

menu_httpd(){

(yad	--title="SERVIDOR" \
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
	httpd_status
	if [[ $status == "ENCENDIO" ]]
	then
		(yad    --text="El servidor esta ACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=100 \
			--height=100 \
		)
		menu_httpd	
	else
		(yad    --text="El servidor esta INACTIVO" \
		        --timeout=3 \
			--no-buttons \
		        --timeout-indicator=bottom \
			--width=100 \
			--height=100 \
		)
		menu_httpd
	fi
		 
elif [[ $ans -eq 1 ]]
then
	service httpd start
	# USO FUNCION httpd_status PARA COMPROBAR QUE SE ENCENDIO EL servidor
	httpd_status
	if [[ $status == "ENCENDIO" ]]
	then
		opc_confirmation=0
		httpd_confirmation
		menu_httpd
	else
		opc_confirmation=1
		httpd_confirmation
		menu_httpd
	fi
elif [[ $ans -eq 2 ]]
then
	service httpd stop
	# USO FUNCION httpd_status PARA COMPROBAR QUE SE DETUVO EL servidor
	httpd_status
	if [[ $status == "DETUVO" ]]
	then
		opc_confirmation=0
		httpd_confirmation
		menu_httpd
	else
		opc_confirmation=1
		httpd_confirmation
		menu_httpd
	fi
else
	exit
fi

}


# FUNCION PARA COMPROBAR SI EL servidor ESTA ACTIVO O INACTIVO
httpd_status(){
status=$(service httpd status | awk '/Active:/ {print $2}')
if [[ $status == "active" ]]
then
        status="ENCENDIO"
else
        status="DETUVO"
fi
}

# FUNCION PARA MOSTRAR CONFIRMACION DE servidor ENCENDIDO O DETENIDO
httpd_confirmation(){
if [[ $opc_confirmation -eq 0 ]]
then
	(yad    --text="El servidor se "$status \
		--timeout=3 \
		--no-buttons \
		--timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
else
	(yad    --text="ERROR: EL servidor NO SE "$status \
	        --timeout=3 \
		--no-buttons \
	        --timeout-indicator=bottom \
		--width=50 \
		--height=50 \
	)
fi
}

menu_httpd
