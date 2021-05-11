#!/bin/bash

jupyter notebook --generate-config
cat << 'EOF' >> $JUPYTER_CONFIG_DIR/jupyter_notebook_config.py
c.NotebookApp.open_browser = False
#c.NotebookApp.token = ''
EOF
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextension enable collapsible_headings/main
mkdir $JUPYTER_CONFIG_DIR/custom
echo '.container { width: 99% !important; }' > $JUPYTER_CONFIG_DIR/custom/custom.css
