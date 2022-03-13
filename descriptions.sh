#!/bin/sh

OPENAI_API_KEY="YOUR_KEY_HERE"

BRAIN="DMT, LSD, Music, Dune, The Foundation"
DESCRIPTION="Null Zoners vs the Hash Lords is a crypto battle from the future. Null Zoners are rebels against the evil Hash Lords who have outlawed the use of cryptocurrencies. Playing as a Null Zoner, you can travel through the galaxies and retrieve your lost data."
DESCRIPTION_EXAMPLE="Null Zoners description:\nNull zoners are a highly advanced race of cryptobeings capable of quantum teleportation.\n"

while read x; do
	PROMPT="$BRAIN\n\n$DESCRIPTION\n\n$DESCRIPTION_EXAMPLE\n$x description:\n"
	RESULT=$(curl https://api.openai.com/v1/engines/davinci/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
  \"prompt\": \"$PROMPT\",
  \"temperature\": 0.9,
  \"max_tokens\": 150,
  \"top_p\": 1,
  \"frequency_penalty\": 0,
  \"stop\": [\"\n\"],
  \"presence_penalty\": 0.6
}" | jq '.choices[0].text')

	echo "$x;$RESULT"
done < "fractions.txt"
