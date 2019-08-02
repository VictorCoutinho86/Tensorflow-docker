#!/bin/bash

cd /opt

git clone https://github.com/tensorflow/models

cd models/research

protoc object_detection/protos/*.proto --python_out=.

mkdir -p /opt/graph_def

cd /tmp

for model in \
  ssd_mobilenet_v1_coco_11_06_2017 \
  ssd_inception_v2_coco_11_06_2017 \
  rfcn_resnet101_coco_11_06_2017 \
  faster_rcnn_resnet101_coco_11_06_2017 \
  faster_rcnn_inception_resnet_v2_atrous_coco_11_06_2017
do \
  curl -OL http://download.tensorflow.org/models/object_detection/$model.tar.gz
  tar -xzf $model.tar.gz $model/frozen_inference_graph.pb
  cp -a $model /opt/graph_def/
done

ln -sf /opt/graph_def/faster_rcnn_resnet101_coco_11_06_2017/frozen_inference_graph.pb /opt/graph_def/frozen_inference_graph.pb

