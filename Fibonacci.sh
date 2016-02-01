#!/bin/bash
################################

# Check Input for numbers and
# Round up for greater n.5, Round down for lessthen n.5
# And absolute inputs
################################
NumCheck='^-?[0-9]+([.][0-9]+)?$'
ValidInput="NO"
NNumber="NO"
while [ $ValidInput = "NO" ]
do
	if ! [[ $Fibonacci =~ $NumCheck ]]; then
		printf "Please type in a number for n in F(n)"
		read -r Fibonacci
	else
		Fibonacci="$(printf "%.0f" $Fibonacci)"
		if [ $Fibonacci -lt 0 ]; then
			Fibonacci=$[$Fibonacci*-1]
			NNumber="YES"
		fi
		ValidInput="YES"
	fi
done

# Function to restore initial signs
# and end the prime check
################################
RISandEPC() 
{
	if [[ $NNumber = "YES" && $PCheck = "0" ]]; then
		FValue=-$FValue
	fi
	PCheck="1"
}

################################
# Main loop
# Initiate golden ratio values
################################
rootFive=$(echo "sqrt(5)" | bc -l)
GDv=$(echo "(1 + $rootFive) / 2" | bc -l)
GDdv=$(echo "($GDv - 1) * -1" | bc -l)

Count="0"
while [ $Count -ne $Fibonacci ]
do
	# Use golden ratio function to calculate Fibonacci
	################################
	GDvP=$(echo "$GDv ^ $Count" | bc -l)
	GDdvP=$(echo "$GDdv ^ $Count" | bc -l)
	FValue=$(printf "%.0f" $(echo "($GDvP - $GDdvP) / $rootFive" | bc -l))


	# Print out the number that is not prime.
	# and mark them with Buzz for mod 3, Fizz for mod 5.
	# Restore negitive sign.
	################################
	PCount="2"
	PNumber="YES"
	PCheck="0"
	RootFValue=$(printf "%.0f" $(echo "sqrt($FValue)" | bc -l))
	while [[ $PCount -lt $RootFValue && $PCheck -eq 0 ]]
	do
		if [ $(((FValue / PCount) * PCount)) -eq $FValue ]; then
			if [ $(($FValue%3)) = "0" ]; then
				RISandEPC
				echo "Buzz;      $FValue"
			elif [ $(($FValue%5)) = "0" ]; then
				RISandEPC
				echo "Fizz;      $FValue"
			else
				RISandEPC
				echo "           $FValue"
			fi
			PNumber="NO"
		fi
		PCount=$[$PCount+1]
	done
	
	# Print out prime number
	################################
	if [ $PNumber = "YES" ]; then
		RISandEPC
		echo "BuzzFizz;  $FValue"
	fi
	Count=$[$Count+1]
done

