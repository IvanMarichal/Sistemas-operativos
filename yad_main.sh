#!/bin/bash

(yad	--title="CONTROL DE FUNCIONALIDADES" \
	--width=500 \
	--center \
	--text-align=center \
	--back=black \
	--form \
	--text="<b>Funcionalidad a controlar:</b>" \
	--field='Motor:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_mysqld.sh" \
	--field='Servidor:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_httpd.sh" \
	--field='Procesos en ejecucion:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_process.sh" \
	--field='Usuarios conectados:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_users.sh" \
	--field='Conexion remota:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_sshd.sh" \
	--field='Estado de puertos:BTN' "sh /home/ezequiel/Desktop/yad_functions/yad_nmap.sh" \
	--button='Salir' :exit \
)
