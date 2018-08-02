#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-s sample_name -d id] reads1.fq reads2.fq
exit 1
}

while getopts  ":s:d:p:t:k:" opts
do
    case  $opts  in
        s) sample_name=$OPTARG;;
        d) id_=$OPTARG;;
        p) out_prefix=$OPTARG;;
        k) kmer_size=$OPTARG;;
        t) threads=$OPTARG;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 2 ]; then info; fi


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


read_group=\
@RG\\tID:${id_:=${sample_name}}\\tPL:ILLUMINA\\tSM:$sample_name\\tLB:${library:=${sample_name}}

reads_seq_1=$1
reads_seq_2=$2

echo; echo; echo start bwa mem ...
$bwa mem -M -t${threads:=4} `opt -k $kmer_size` -R $read_group $ref_genome \
$reads_seq_1 \
$reads_seq_2 | samtools view -b -@$threads - > $out_prefix.bam


. $cmd_done


