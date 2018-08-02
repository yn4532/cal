#!/bin/bash

function info() {
    echo Usage: `basename $0` package_name
    exit 1
}

while getopts ":p:" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

. ~/.config/yfulrc


echo $ref_genome

echo test
get_abs abc

set_done

