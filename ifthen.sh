#!/bin/bash
#scripts that tell how much days are in current month
month=$(date -d "$D" '+%m')
year=$(date -d "$D"  '+%Y')
months30=("04" "06" "09" "11")
months31=("01" "03" "05" "07" "08" "10" "12")
if [[ " ${months31[*]} " =~ $month ]]
then
	echo "31 days"
elif [[ $months30[*] =~ $month ]]
then
	echo "30 days"
else
	if [ $[$year % 4] -eq 0 ]
	then
		echo "29 days"
	else
		echo "28 days"
	fi
fi
