#!/bin/bash
for j in $(cat languages)
	do
		for i in $(cat words)
		do
			out=$(bash ./trans.sh -b  -t $j -e bing $i);
			echo "$i -> $out";
			echo "$i -> $out" >> $j;			
		done
	done 






