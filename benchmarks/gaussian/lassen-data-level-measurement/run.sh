#!/bin/bash
for i in `seq 0 6`;
do
for j in `seq 0 6`;
do
for k in `seq 0 6`;
do
#echo $i $j $k
#echo "nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix4.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix4.txt"
nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix4.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix4.txt > /dev/null 2>&1
nvprof --unified-memory-profiling per-process-device --print-gpu-trace ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix4.txt &>  lassen-log/GPUTraceOutput_$i$j${k}_matrix4.log 
#echo "nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix208.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix208.txt"
nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix208.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix208.txt > /dev/null 2>&1
nvprof --unified-memory-profiling per-process-device --print-gpu-trace ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix208.txt &>  lassen-log/GPUTraceOutput_$i$j${k}_matrix208.log 
#echo "nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix1024.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix1024.txt"
nvprof -u ms --log-file lassen-log/output_$i$j${k}_matrix1024.log ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix1024.txt > /dev/null 2>&1
nvprof --unified-memory-profiling per-process-device --print-gpu-trace ./lassen/gaussian_$i$j$k -q -f ../../../data/gaussian/matrix1024.txt &>  lassen-log/GPUTraceOutput_$i$j${k}_matrix1024.log 

for d in `seq 16 16 1024`;do
#echo "nvprof -u ms --log-file lassen-log/output_$i$j${k}_16.log ./lassen/gaussian_$i$j$k -q -s 16" 
nvprof -u ms --log-file lassen-log/output_$i$j${k}_${d}.log ./lassen/gaussian_$i$j$k -q -s $d > /dev/null 2>&1
nvprof --unified-memory-profiling per-process-device --print-gpu-trace ./lassen/gaussian_$i$j$k -q -s $d &>  lassen-log/GPUTraceOutput_$i$j${k}_${d}.log 
done    

done    
done    
done    
