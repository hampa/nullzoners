#!/bin/bash

ls images > tmp.txt

ls images | cut -d '|' -f1 | cut -d ' ' -f3- | sort -u > fractions.txt
exit
while read x; do
	y=$(echo $x | cut -d '|' -f1)
	echo y=$y
done < tmp.txt
