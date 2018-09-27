#!/bin/bash

# splits the JGI raw reads (ie not filtered) for each plate scrape sample.


# usage and parameters
usage="$(basename "$0") [-h] [-d str]  -- gathers read counts and bp counts for plate scrape samples

where:
    -h  show this help text
    -d  directory containing the raw data (default: .)"

data_dir=`pwd`
while getopts ':hd:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    d) data_dir=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))


### MAIN ###
