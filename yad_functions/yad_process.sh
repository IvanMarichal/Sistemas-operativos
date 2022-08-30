#!/bin/bash
(yad	--title="Control de procesos" \
	--width=500 \
	--center \
	--text-align=center \
	--text="Que va a realizar:" \
	--button="Estado de los procesos":0 \
	--button="Cerrar":1 \
)
ans=$?

if [[ $ans -eq 0 ]]
then		
	ps=$(ps)
	(yad    --title="Procesos:" \
		--text="$ps" \
		--button="Volver":0 \
		--width=50 \
		--height=50 \
	)
	btn=$?
	if [[ $btn -eq 0 ]]
	then
		exit | sh yad_process.sh
	fi
else
	exit
fi


