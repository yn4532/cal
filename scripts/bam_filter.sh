#!/bin/bash
set -e

function info() {
echo Usage: `basename $0` [-iqfF] bam
exit 1
}

while getopts  ":s:d:p:i:q:f:F" opts
do
    case  $opts  in
        s) sample_name=$OPTARG;;
        d) id_=$OPTARG;;
        p) out_prefix=$OPTARG;;
        i) interval=$OPTARG;;
        q) quality=$OPTARG;;
        f) flag=$OPTARG;;
        F) Flag=$OPTARG;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi


. $var


function opt() {
    if test -n "$2"; then 
        echo $1 $2
    fi
}

function default() {
    if test -z "$1"; then
        eval $1=$2
    fi
}

default threads 4

samtools view -b -@${threads:=4} `opt -q $quality` `opt -F $Flag` `opt -f $flag` `opt -L $interval` $1 > $out_prefix.filter.bam
bam_index.sh -p$out_prefix $out_prefix.filter.bam

. $cmd_done


