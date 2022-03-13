#!/bin/sh

DESCFILE="desc.txt"
echo "array(" "Peter"=>"35"
while read x; do
	ipfs_image=$(echo $x | cut -d ' ' -f1)
	ipfs_json=$(echo $x | cut -d ' ' -f3- | cut -d '.' -f1) 
	grep "$name" desc.txt >/dev/null || exit 1
	echo "\"$ipfs_image\"=>\"$ipfs_json\","
	#echo "json/$ipfs.json"
done < "alljson.txt"
