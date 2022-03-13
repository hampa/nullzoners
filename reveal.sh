#!/bin/sh

OPENAI_API_KEY="YOUR_KEY_HERE"

BRAIN="DMT, LSD, Music, Dune, The Foundation, Cosmic War"
DESCRIPTION="Null Zoners vs the Hash Lords is a crypto game from the future raging in the present.Null zoners are rebels against the evil Hash Lords who have outlawed the use of cryptocurrencies."
DESCRIPTION_EXAMPLE="One sentence that make anyone want to play it:\n"

while read x; do
	PROMPT="x$,$BRAIN\n\n$DESCRIPTION\n\n$DESCRIPTION_EXAMPLE"
	RESULT=$(curl https://api.openai.com/v1/engines/davinci/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
  \"prompt\": \"$PROMPT\",
  \"temperature\": 0.9,
  \"max_tokens\": 150,
  \"top_p\": 1,
  \"frequency_penalty\": 0,
  \"presence_penalty\": 0.6
}" | jq '.choices[0].text')

	echo "$RESULT"
	exit
done < "fractions.txt"
  #\"stop\": [\"\n\"],
