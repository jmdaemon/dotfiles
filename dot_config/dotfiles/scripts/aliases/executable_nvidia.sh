#!/bin/bash

alias nvsmi="watch -n 1 nvidia-smi"
alias nvsmc="nvidia-smi --query-gpu=timestamp,pstate,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 1"
alias nvhelp="nvidia-smi --help-query-gpu"
alias nvmem="nvidia-smi --query-gpu=timestamp,memory.used,memory.total --format=csv -l 1"
alias nvcent="nvidia-smi dmon -s u"

# PyPi pip3 install nvidia-ml-py3
# Conda conda install nvidia-ml-py3 -c fastai
