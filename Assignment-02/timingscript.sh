#!/bin/bash
num=$RANDOM
m=$(($num%$3	+1))

start=$(date +%s%N)
count=0
for (( i=$1 ; i<=$2 ; i=i+1 )); 
do
	for (( j=$1 ; j<=$2 ; j=j+1 )); 
	do
		./program $i $j $m >/dev/null 2>&1
		(( count++ ))
    done
done
end=$(date +%s%N)

run_time=$(echo "($end - $start)/ 1000000000" | bc -l)
total_runs=$((($2-$1+1)*($2-$1+1)))
average_time=$(echo "( $run_time / $count )" | bc -l)
printf "%.3f %.3f \n" $run_time $average_time
