#!/bin/bash -e

function info() {
    echo Usage: `basename $0` [-p out_prefix -s out_suffix] list
    exit 1
}

while getopts ":p:s:t:i:" opt; do
    case $opt in
        p) out_prefix=$OPTARG;;
        s) out_suffix=$OPTARG;;
        t) threads=$OPTARG;;
        i) interval=$OPTARG;;
        ?) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi

export YFUL_RC=~/.config/yfulrc
export var=$YFUL_RC
. $var

num=`awk 'END{print NR}' $1`

for i in `seq $num`; do
    name=`awk -v n=$i 'NR==n{print $1}' $1`
    r1=`awk -v n=$i 'NR==n{print $2}' $1`
    r2=`awk -v n=$i 'NR==n{print $3}' $1`
    echo $name $r1 $r2
    eval mapping_calling.sh -p$out_prefix.$name.$i -n$name -i$interval $r1 $r2
done

call_multi.sh -p$out_prefix.all.$num -i$interval .

set_done
