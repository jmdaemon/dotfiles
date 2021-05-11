#!/bin/bash

PYTHON_VER=3.9

create_env() {
    ENV=$1
    conda create -y -n $ENV python=$PYTHON_VER
    conda activate $ENV
    conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

    # Miniconda: conda install -c fastai -c pytorch fastai
    #conda uninstall --force jpeg libtiff -y
    #conda install -y -c conda-forge libjpeg-turbo pillow==7.2.0
    #CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd
    conda deactivate
}

create_env "fastai"
