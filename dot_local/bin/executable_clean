#!/usr/bin/python3.9

import click
import os
import shutil
from pathlib import Path

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])
@click.command(options_metavar='[options]', context_settings=CONTEXT_SETTINGS)
@click.option   ('-V'       , '--version', "version", help='Show program version')
@click.option   ('-v'       , '--verbose', "verbose", help='Show verbose output', default=False)
@click.option   ('-d'       , '--dry-run', "dryrun" , help='Show what files will be deleted without deleting them',
                 is_flag=True, default=False)
@click.argument ('folder'   , metavar="<folder>"    , type=click.Path(exists=True))
@click.argument ('excludes' , metavar="<excludes>"  , required=False)

def cli(version, verbose, dryrun, folder, excludes):
    no_remove = set()
    excludes_list = Path(excludes)

    if (excludes_list.exists() or excludes.is_dir()):
        with open(excludes) as f:
             for line in f:
                 no_remove.add(line.strip())

    os.chdir(folder)
    clean(dryrun, folder, no_remove)

def clean(dryrun, folder, no_remove):
    if dryrun:
        for f in os.listdir(folder):
            if f not in no_remove:
                print('unlink:' + f )
    else:
        for f in os.listdir(folder):
            if f not in no_remove:
                if os.path.isfile(f):
                    print('unlink:' + f )
                    os.unlink(f)
                elif os.path.isdir(f):
                    print('rmdir:' + f )
                    try:
                        shutil.rmtree(f)
                    except OSError as e:
                        print ("Error: %s - %s." % (e.filename, e.strerror))

if __name__ == '__main__':
    cli()
