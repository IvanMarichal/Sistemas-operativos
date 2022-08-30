#!/bin/bash

(yad	--title="Control de usuarios" \
	--width=500 \
	--center \
	--text-align=center \
	--text="Que va a realizar:" \
	--button="Usuarios conectados":0 \
	--button="Cerrar":1 \
)
ans=$?

if [[ $ans -eq 0 ]]
then		
	who=$(who)
	(yad    --title="Usuarios:" \
		--text="$who" \
		--button="Volver":0 \
		--width=50 \
		--height=50 \
	)
	btn=$?
	if [[ $btn -eq 0 ]]
	then
		exit | sh yad_users.sh
	fi
else
	exit
fi


