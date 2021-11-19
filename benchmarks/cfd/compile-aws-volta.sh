#!/bin/bash
# configure environment based on your machine
INCLUDE_OPT="-I/usr/local/cuda-10.2/samples/common/inc -I../../cuda-adapter"
LINK_FLAGS="-L/usr/local/cuda-10.2/lib64"
BIN_PATH=`hostname`-executable

mkdir -p ./GPU-executable
for i in `seq 0 6`;
do
for j in `seq 0 6`;
do
for k in `seq 0 6`;
do
echo $m $i $j $k
nvcc  -O2 -Xptxas -v --gpu-architecture=compute_70 --gpu-code=compute_70 euler3d-adapt.cu ../../cuda-adapter/adapter.o -o euler3d_adapt $INCLUDE_OPT $LINK_FLAGS -lnvToolsExt -Dadv1=$i -Dadv2=$j -Dadv3=$k  
mv euler3d_adapt ./GPU-executable/cfd_$m$i$j$k
done    
done    
done    
        
