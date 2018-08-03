#!/bin/bash -e

function info() {
    echo Usage: `basename $0` package_name
    exit 1
}

while getopts ":p:m:d:J" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        m) mem=$OPTARG;;
        d) dir=$OPTARG;;
        J) j=n;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

test -z "$j" && jar='-jar'

echo java -Djava.io.tmpdir=${dir:=tmp} -Xmx${mem:=4g} $jar $@
eval java -Djava.io.tmpdir=$dir -Xmx$mem $jar $@

