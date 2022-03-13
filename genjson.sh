#!/bin/sh

collection="Null Zoners vs The Hash Lords"
DESCFILE="desc.txt"
while read x; do
	ipfs=$(echo $x | cut -d ' ' -f1)
	name=$(echo $x | cut -d ' ' -f5- | cut -d '|' -f1 | tr -d '.')
	grep "$name" desc.txt >/dev/null || exit 1
	desc=$(grep "$name" desc.txt | cut -d ';' -f2- | tr -d '"')
	#echo "$name DESCRIPTION: $desc"
	echo "json/$ipfs.json"
cat <<EOF > json/$ipfs.json
{
        "name": "$collection",
	"fraction": "$name",
        "description": "$desc",
        "image": "https://ipfs.io/ipfs/$ipfs?filename=$name",
        "seller_fee_basis_points": 100,
        "fee_recipient": "0xc34b7636942152641205b52e6b3a067c4c64721f"
}
EOF
done < "all.txt"
