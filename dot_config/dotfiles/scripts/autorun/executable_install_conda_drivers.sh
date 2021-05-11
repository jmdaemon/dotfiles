#!/bin/bash

# install_conda_drivers.sh

CUDA=http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
CUDNN=http://files.fast.ai/files/cudnn-10.2-linux-x64-v7.6.5.32.tgz

URL="https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.11/rc2/"
SWIFT="swift-tensorflow-RELEASE-0.11-cuda10.2-cudnn7-ubuntu18.04.tar.gz"
ENV="swift"

SWIFT_DEPS=(
    git cmake ninja-build clang 
    python uuid-dev libicu-dev icu-devtools 
    libbsd-dev libedit-dev libxml2-dev libsqlite3-dev 
    swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev 
    libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync 
)

setup_cuda() {
    cd $HOME/Downloads
    wget $CUDA
    chmod u+x cuda_1*_linux*
    sudo ./cuda_*_linux.run --silent --toolkit
    echo /usr/local/cuda/lib64 | sudo tee -a /etc/ld.so.conf
    sudo ldconfig
}

setup_cudnn() {
    cd $HOME/Downloads
    wget $CUDNN
    tar xf cudnn-10*.tgz
    sudo cp cuda/include/cudnn.h /usr/local/cuda/include
    sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
    sudo ldconfig
}

install_swift_deps() { 
    sudo apt-fast -y install ${SWIFT_DEPS[@]}
}

setup_swift() {
    mkdir -p ~/swift/
    wget $URL/$SWIFT -P ~/Downloads 
    tar xf $HOME/Downloads/swift-tensorflow-*.tar.gz
    mv ~/Downloads/usr ~/swift/
    cd $HOME/git/swift-jupyter/ && git pull origin master
    conda activate $ENV
    python register.py --sys-prefix --swift-python-use-conda --use-conda-shared-libs  --swift-toolchain ~/swift
}

show_usage() {
    echo "Usage: install_conda_drivers.sh [option]"
    echo "  --cuda,                 Downloads and installs NVidia Cuda 10.2 drivers, and 
                                        adds /usr/local/cuda/lib64 to /etc/ld.so.conf"
    echo ""
    echo "  --cudnn,                Downloads cudnn 10.2, and installs cudnn.h and libcudnn, 
                                        into /usr/local/cuda/include and /usr/local/cuda/lib64"
    echo ""
    echo "  --swift [conda_environment],  Downloads swift-tensorflow into ~/swift directory, and registers 
                                        [conda_environment] as a swift kernel for Jupyter Notebooks"
    echo ""
    echo "  -a, --all               Installs cuda, cudnn and swift"
    echo ""
}


if [[ -z $1 ]];then 
    show_usage
elif [[ $1 == "--cuda" ]]; then
    setup_cuda
elif [[ $1 == "--cudnn" ]]; then
    setup_cudnn
elif [[ $1 == "--swift" ]]; then
    setup_swift
elif [[ ! -z $2 && ($1 == "-a" || $1 == "--all") ]]; then 
    ENVS_LIST=$(conda info --envs | tail -n +3 | awk '{print $1}' | awk '{printf $1 " "}END{printf "\n"}')
    if echo ${ENVS_LIST[@]} | grep -q -w $2
        then
            setup_cuda
            setup_cudnn
            install_swift_deps
            setup_swift
    fi
else
    show_usage
fi
