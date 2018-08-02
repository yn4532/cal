#!/bin/bash -e

function info() {
    echo Usage: `basename $0` '[-n sample_name] r1 r2'
    exit 1
}

while getopts ":p:f:n:r:i:" opt; do
    case  $opt  in
        p) out_prefix=$OPTARG;;
        f) suffix=$OPTARG;;
        n) name=$OPTARG;;
        i) interval=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 2 ]; then info; fi


. $var


if test -z "$name"; then
name=test
fi

fastqc.sh -s$name $1
fastqc.sh -s$name $2

fp.sh -p$out_prefix $1 $2

fastqc.sh -p$out_prefix.r1 $out_prefix.r1.fq
fastqc.sh -p$out_prefix.r2 $out_prefix.r2.fq


align2bam.sh -s$name -p$out_prefix $out_prefix.r1.fq $out_prefix.r2.fq

bam_sort_index.sh -p$out_prefix $out_prefix.bam
samtools flagstat $out_prefix.sort.bam > $out_prefix.sort.bamstat.txt

bam_filter.sh -p$out_prefix -q20 -i$interval $out_prefix.sort.bam
samtools flagstat $out_prefix.filter.bam > $out_prefix.filter.bamstat.txt


deldup.sh -p$out_prefix $out_prefix.filter.bam
samtools flagstat $out_prefix.deldup.bam > $out_prefix.deldup.bamstat.txt


realign_bam.sh -p$out_prefix -i$interval $out_prefix.deldup.bam


bqsr.sh -l$bed -p$out_prefix $out_prefix.realn.bam
samtools flagstat $out_prefix.recal.bam > $out_prefix.recal.bamstat.txt
fastqc.sh -p$out_prefix.realn $out_prefix.recal.bam
summ_gatk.sh -p$out_prefix.recal $out_prefix.recal.bam $interval

hap.sh -p$out_prefix -i$interval $out_prefix.recal.bam

. $cmd_done
