#!/usr/bin/env python

"""A simple python script template.
"""

import os
import sys
import argparse
import logging


def main(arguments):

    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-i', '--infile', help="Input file", 
            type=argparse.FileType('r'))
    parser.add_argument('-o', '--outfile', help="Output file",
            default=sys.stdout, type=argparse.FileType('w'))
    parser.add_argument('-l', '--logfile', help="Log file",
            default="log", type=str)

    args = parser.parse_args(arguments)

    logging.basicConfig(filename='log',level=logging.DEBUG)

    print(args)

if __name__ == '__main__':
aadfasdf    sys.exit(main(sys.argv[1:]))
