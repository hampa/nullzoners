#!/bin/sh

while read x; do
	name=$(echo $x | cut -d ';' -f1| tr -d '"')
	desc=$(echo $x | cut -d ';' -f2- | tr -d '"')	
	#echo $name and $desc
cat <<EOF > json/$name.json
{
        "name": "$name",
        "description": "$desc",
        "image": "IMAGE",
        "seller_fee_basis_points": 100,
        "fee_recipient": "0xc34b7636942152641205b52e6b3a067c4c64721f"
}
EOF
done < "desc.txt"
