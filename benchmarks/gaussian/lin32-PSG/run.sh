#!/bin/bash
for m in `seq 0 1`;
do
for i in `seq 0 5`;
do
for j in `seq 0 5`;
do
for k in `seq 0 5`;
do
#echo $i $j $k
#echo "nvprof -u ms --log-file output_$m$i$j${k}_matrix4.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix4.txt"
nvprof -u ms --log-file output_$m$i$j${k}_matrix4.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix4.txt > /dev/null 2>&1
#echo "nvprof -u ms --log-file output_$m$i$j${k}_matrix208.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix208.txt"
nvprof -u ms --log-file output_$m$i$j${k}_matrix208.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix208.txt > /dev/null 2>&1
#echo "nvprof -u ms --log-file output_$m$i$j${k}_matrix1024.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix1024.txt"
nvprof -u ms --log-file output_$m$i$j${k}_matrix1024.log ./gaussian_$m$i$j$k -f ../../../data/gaussian/matrix1024.txt > /dev/null 2>&1

for d in `seq 16 16 1024`;do
#echo "nvprof -u ms --log-file output_$m$i$j${k}_16.log ./gaussian_$m$i$j$k -s 16" 
nvprof -u ms --log-file output_$m$i$j${k}_${d}.log ./gaussian_$m$i$j$k  -s $d > /dev/null 2>&1
done
done    
done    
done    
done    
