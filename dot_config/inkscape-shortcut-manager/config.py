import subprocess

def open_editor(filename):
    subprocess.run([
        'alacritty',
        '--class', 'popup-bottom-center,popup-bottom-center',
        '-e', "nvim",
        f"{filename}",
        '-u', '~/.config/nvim/.min.vimrc'
    ])

def latex_document(latex):
    return r"""
        \documentclass[12pt,border=12pt]{standalone}
        \usepackage[utf8]{inputenc}
        \usepackage[T1]{fontenc}
        \usepackage{textcomp}
        \usepackage{amsmath, amssymb}
        \newcommand{\R}{\mathbb R}
        \usepackage{cmbright}
        \begin{document}
    """ + latex + r"\end{document}"


config = {
    'font': 'Inconsolata Nerd Font',
    'open_editor': open_editor,
    'latex_document': latex_document
}
