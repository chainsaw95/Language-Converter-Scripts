#!/bin/bash

bash ./trans.sh -R
	
echo "Enter the language code you want to test";
read lang;

echo "Enter word to test"
read word;

# We run a test run with the test word and the list
# of engines to see whats best.
# Recommended: google and bing
# Google will block your request if the file size is large, 
# Bing always seems to work fine. 

# For every engine in the engine list 
# out is a variable that stores the output of the test translation
# $? is the return code of the last executed command.
# If the test translation executes , show the sample translated texts to judge for accuracy

for j in $(cat ./engine_list)
do
	out=$(./trans.sh -b  -t $lang -e $j $word 2> /dev/null);
	  
	if [ $? == 0 ]; then                   
	 	echo "engine $j working -> $out ";
	fi
done 

# now the user is finished with test translation from various engines on the list
# and can now select an engine based on availibilty and accuracy

echo "Enter the engine you want to use for the translation";
read engine;

# Setting the Internal file seperator as \n so files are processed line by line
# i iterates over every line in the english_lang file 
# sed 's/[ ;]*$//' english_lang removes all ; (not permanently) and the output is stored in i

IFS=$'\n'

for i in $(sed 's/[ ;]*$//' english_lang); do

  key=$(echo $i | awk -F'=' {'print $1 '});
  text=$(echo $i| awk -F'=' {'print $2'});

  if [[ $text = *[!\ ]* ]]; then

		value=$(./trans.sh -b  -t $lang -e $engine $text);
		value=$(echo $value| tr -d '"');
		echo "$key =\"$value\"";
		echo "$key =\"$value\";" >> output.txt;

  fi
done


