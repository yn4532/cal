#!/bin/bash

function info() {
    echo Usage: `basename $0`
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


# if [ $# -lt 1 ]; then info; fi

export YFUL_RC=~/.config/yfulrc
export var=$YFUL_RC
. $var

for i in ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/1000G_phase1.snps.high_confidence.hg38.vcf.gz ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/dbsnp_146.hg38.vcf.gz ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/beta/Homo_sapiens_assembly38.known_indels.vcf.gz ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/beta/Homo_sapiens_assembly38.variantEvalGoldStandard.vcf.gz ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/beta/NISTIntegratedCalls.hg38.vcf.gz
do
    wget -c ${i}*
done

set_done

