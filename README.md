# Ovule-Detection
*This project was conducted for an Image Processing course final exam*

## Purpose
The project is aimed to design a computer vision algorithm which detects ovules in a video. In order to realize this, it applies a segmentation function on each frame, generating a new video in which a circles surrounds ovules.

## Pre-processing
For segmentation of the data, each frame is pre-processed by applying the following:
* 5x5 average filters (10 times)
* Erosion with a 10 radius disk structural element (1 time)
* Closure with a 10 radius disk structural element (10 times)
* Maximizing contrast

## Segmentation
Segmentation is conducted through the following:
* Border detection through Canny
* Finding circles in borders with a changing radius

## Video reconstruction
A new video is reconstruced with each old frame from the previous video being replaced with a new frame which includes the circles found plotted surrounding each ovule.
