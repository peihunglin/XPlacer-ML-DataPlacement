#!/bin/bash
# configure environment based on your machine
INCLUDE_OPT="-I/usr/local/cuda-10.2/samples/common/inc -I../../cuda-adapter"
LINK_FLAGS="-L/usr/local/cuda-10.2/lib64"
BIN_PATH=`hostname`-executable

mkdir -p GPU-executable

for i in `seq 0 6`;
do
for j in `seq 0 6`;
do
echo $m $i $j
nvcc  hotspot-adapt.cu ../../cuda-adapter/adapter.o -o hotspot-adapt $INCLUDE_OPT $LINK_FLAGS -Dadv1=$i -Dadv2=$j 
mv hotspot-adapt ./GPU-executable/hotspot_$m$i$j$k
done    
done    
        
