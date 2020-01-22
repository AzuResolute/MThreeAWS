#!/bin/bash

counter=0
while [ $counter -le 10 ]
do
	echo $counter
	counter=$[counter+2]
done
