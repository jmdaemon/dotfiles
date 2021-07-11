#!/usr/bin/python3.9

import click
import os
from pathlib import Path

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])
@click.command(options_metavar='[options]', context_settings=CONTEXT_SETTINGS)
@click.option   ('-V'       , '--version', "version", help='Show program version')
@click.option   ('-v'       , '--verbose', "verbose", help='Show verbose output', default=False)
@click.argument ('folder'   , metavar="<folder>"    , type=click.Path(exists=True))
@click.argument ('excludes' , metavar="<excludes>"  , required=False)

def cli(version, verbose, folder, excludes):
    no_remove = set()
    excludes_list = Path(excludes)

    if (excludes_list.exists()):
        with open(excludes) as f:
             for line in f:
                 no_remove.add(line.strip())

    os.chdir(folder)
    for f in os.listdir(folder):
        if f not in no_remove:
            print('unlink:' + f )
            os.unlink(f)

if __name__ == '__main__':
    cli()
