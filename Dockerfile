FROM nvidia/cuda:11.4.3-devel-ubuntu18.04 as dependencies

# Make sure you install right tag such that it has the same
# cuda version as cuda installed on your machine

WORKDIR /opt
