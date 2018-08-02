#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-i in.bed] in.bam
exit 1
}

while getopts  ":i:r:n:p:" opts
do
    case  $opts  in
        i) interval=$OPTARG;;
        r) realn_interval=$OPTARG;;
        p) out_prefix=$OPTARG;;
        n) data_thread_num=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi


. $var


vcf_path=${data_path}/vcf/gatk/

if [ -n "$interval" ]; then interval="-L $interval"; fi

echo; echo gatk RealignerTargetCreator recommand nt 24 mem 48
java $j_mem -jar $gatk \
    -T RealignerTargetCreator \
    -R $ref_genome $interval\
    -I $1 \
    -o $out_prefix.realn.intervals \
    -log $out_prefix.realn.log \
    -nt $data_thread_num \
    -known ${vcf_path}1000G_phase1.indels.${genome_assembly}.vcf \
    -known $data_path/gatk/vcf/Mills_and_1000G_gold_standard.indels.${genome_assembly}.vcf

realn_interval=$out_prefix.realn.intervals


echo; echo; echo gatk IndelRealigner recommand sg 4 mem 4
java $j_mem -jar $gatk \
    -T IndelRealigner \
    -R $ref_genome $interval\
    -targetIntervals $realn_interval \
    -I $1 \
    -o $out_prefix.realn.bam \
    -log $out_prefix.realn2.log \
    -known ${vcf_path}1000G_phase1.indels.${genome_assembly}.vcf \
    -known ${vcf_path}Mills_and_1000G_gold_standard.indels.${genome_assembly}.vcf


. $cmd_done
