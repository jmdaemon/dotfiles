#!/bin/bash

pip_is_installed() {
    pkg="$1"
    return pip list | grep "$pkg"
}

if [[ -e $JUPYTER_CONFIG_DIR/jupyter_notebook_config.py ]]; then
    echo "Jupyter Notebook is already configured"
    exit
else
    jupyter notebook --generate-config
    cat << 'EOF' >> $JUPYTER_CONFIG_DIR/jupyter_notebook_config.py
    c.NotebookApp.open_browser = False
    #c.NotebookApp.token = ''
EOF
fi

[[ -z $(pip_is_installed jupyter_contrib_nbextensions) ]] && pip install jupyter_contrib_nbextensions || :

if [[ ! -d "$JUPYTER_CONFIG_DIR" ]]; then
    jupyter contrib nbextension install --user
    jupyter nbextension enable collapsible_headings/main
fi

[[ ! -d "$JUPYTER_CONFIG_DIR/custom" ]] && mkdir $JUPYTER_CONFIG_DIR/custom || :
if [[ ! -e "$JUPYTER_CONFIG_DIR/custom/custom.css" ]]; then
    echo '.container { width: 99% !important; }' > $JUPYTER_CONFIG_DIR/custom/custom.css
fi
