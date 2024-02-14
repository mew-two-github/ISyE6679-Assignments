#!/bin/bash
echo "min: $1"
echo "max: $2"
echo "num: $3"
num=$RANDOM
m=$(($num%$3	+1))

start=$(date +%s%N)
echo "$start"
echo "Run starts"
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
echo "$end"
run_time=$(echo "($end - $start)/ 1000000000" | bc -l)
echo "runtime = $run_time"
total_runs=$((($2-$1+1)*($2-$1+1)))
echo "total runs = $total_runs count = $count"
average_time=$(echo "( $run_time / $count )" | bc -l)
echo "average time = $average_time"
printf "%.3f %.3f \n" $run_time $average_time
