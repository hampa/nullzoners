
while read x; do
	ipfs=$(echo $x | cut -d ' ' -f1)
	file=$(echo $x | cut -d ' ' -f3-)
	grep "$name" desc.txt >/dev/null || exit 1
	desc=$(grep "$name" desc.txt | cut -d ';' -f2- | tr -d '"')
	#echo "$ipfs file:$file"
	cp "images/${file}" "cache/$ipfs.png" || exit 1
done < "all.txt"

echo done
