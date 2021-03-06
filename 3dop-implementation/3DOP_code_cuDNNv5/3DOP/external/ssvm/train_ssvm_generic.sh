#!/bin/bash

# feature folder
DIR=/u/xiaozhi/cache/3DOP-generic/features
# training set: 'train' or 'trainval'
TRAIN_SET=train
# number of iterations
ITER=5

# IoU threshold for positive samples
IOU=60

# copy the trained model to this folder
OUT_DIR=../../data/models-generic
if [ ! -d $OUT_DIR ]; then
    mkdir -p $OUT_DIR
fi

# cache trained models to this folder
CACHE_DIR=generic/models
FILE_PREFIX=ssvm_${TRAIN_SET}
if [ ! -d $CACHE_DIR ]; then
    mkdir -p $CACHE_DIR
fi
FEAT_DIR=$DIR/$TRAIN_SET

# run it
mpirun -np 30 ./structSVMCP -i $ITER -c 0.1 -p *.pos$IOU -d $FEAT_DIR -o $CACHE_DIR/$FILE_PREFIX

let EXT=$ITER-1
cp ${CACHE_DIR}/${FILE_PREFIX}.$EXT $OUT_DIR/$FILE_PREFIX
