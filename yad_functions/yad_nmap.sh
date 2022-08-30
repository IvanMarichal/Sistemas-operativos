#!/bin/bash

menu_nmap(){
(yad	--title="CONSULTAR PUERTOS" \
	--width=500 \
	--center \
	--text-align=center \
	--text="Puertos:" \
	--button='Conexion remota':22 \
	--button='Motor mysql':3306 \
	--button='Servidor HTTP':80 \
	--button='Servidor HTTPS':433 \
)
port=$?

status=$(nmap -p $port localhost | awk 'NR==7 {print $2}')

(yad    --text="El estado del puerto es: $status" \
	--timeout=3 \
	--no-buttons \
	--timeout-indicator=bottom \
	--width=50 \
	--height=50 \
)

}

menu_nmap

