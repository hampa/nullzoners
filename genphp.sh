#!/bin/sh

DESCFILE="desc.txt"
echo "array(" "Peter"=>"35"
while read x; do
	ipfs=$(echo $x | cut -d ' ' -f1)
	name=$(echo $x | cut -d ' ' -f5- | cut -d '|' -f1 | tr -d '.')
	grep "$name" desc.txt >/dev/null || exit 1
	desc=$(grep "$name" desc.txt | cut -d ';' -f2- | tr -d '"')
	echo "\"$ipfs\"=>\"$name\","
	#echo "json/$ipfs.json"
done < "all.txt"
