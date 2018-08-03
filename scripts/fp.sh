#!/bin/bash -e

function info() {
    echo Usage: `basename $0` '[-wrb] r1 r2'
    exit 1
}

while getopts ":p:f:w:r:b:" opt; do
    case  $opt  in
        p) out_prefix=$OPTARG;;
        f) suffix=$OPTARG;;
        w) win_len=$OPTARG;;
        r) read_th=$OPTARG;;
        b) bed=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi

. $var

trim3_r1=1
trim3_r2=1
trim5_r1=0
trim5_r2=0
min_len=35
threads=6

fastp \
-i $1 -I $2 \
-o $out_prefix.r1.fq -O $out_prefix.r2.fq \
-f $trim5_r1 \
-t $trim3_r1 \
-F $trim5_r1 \
-T $trim3_r2 \
-q 15 -u 40 \
-l $min_len \
-w $threads \
-h $out_prefix.fastp.html \
-j $out_prefix.fastp.json \
-R "$1 and $2 report"

. $cmd_done

