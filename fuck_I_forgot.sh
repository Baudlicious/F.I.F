# Grabs notes from ~/.resources folder and displays on screen

#!/bin/bash

ref="$HOME/.resources/"
red="\033[1;35m"
nc="\033[0m"
title="\033[1;4;32m"

#Add an entry to a sheet
function f_add {
	echo "[+] Adding entry to resource..."
	read -p "Title for new entry : " new_entry
	echo "$new_entry: " >> $1
	echo -e ".........................................................................\n" >> $1
	read -p "Snip for new entry : " entry_code
	read -p "Function of entry : " funct_entry
	echo -e "${red}$entry_code${nc} \t$funct_entry\n" >> $1
}


#Add a new sheet
function f_new {
	echo "[+] New sheet being created..."
	touch $1
	read -p "Title for sheet : " new_sheet_title
	touch $1
	echo -e "${title}$new_sheet_title${nc}\n" >> $1
}

#If no resource folder is present make one
if [[ ! -d $ref ]] ; then
	echo "$0: You don't seem to have a .resources folder" >&2
	echo "To remedy this, I've made one" >&2
	mkdir $ref
	exit 1
fi


#If no arguements are provided then prompt & exit
if [[ $# -eq 0 ]] ; then
	echo -e "Provide a sheet!"
	exit 1
fi

if [[ $1 == "-e" ]] ; then
	echo "[+] Editing $2"
	vim "$REF$2"
elif [[ $1 == "-a" ]] ; then
	f_add $ref$2
elif [[ $1 == "-n" ]] ; then
	f_new $ref$2
	f_add $ref$2
else
	more -d "$REF$1"
fi

exit 0
