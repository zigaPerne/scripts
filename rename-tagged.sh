#!/bin/sh

for f in *.png; do
	num=$(echo $f | sed 's/tagged//' | sed 's/\.png//g')
	padded=$(printf "%04d\n" $num)
	mv $f "tagged$padded.png"
done
