#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'in.sam'
exit 1
}

while getopts  ":p:f:" opt; do
    case  $opt  in
        p) out_prefix=$OPTARG;;
        f) suffix=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

. $var

echo samtools sort

default threads 4

samtools 2>&1|grep Version
samtools sort -@${threads:=4} -T$out_prefix.t -o$out_prefix.sort.bam $1

echo samtools index
samtools index $out_prefix.sort.bam

. $cmd_done
