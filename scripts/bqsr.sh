#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-t] [-l in.bed] in.bam
exit 1
}

while getopts  ":l:p:t:" opts
do
        case  $opts  in
		l) interval=$OPTARG;;
		p) out_prefix=$OPTARG;;
		t) cpu_thread_num=$OPTARG;;
		*) info;;
        esac
done
shift $(($OPTIND - 1))

if [ -z $1 ]; then info; fi

. $var

test -n "$interval" && interval="-L $interval"

echo
echo gatk BaseRecalibrator nct $cpu_thread_num recommand nct 8 mem 4
java.sh -m$java_memory -d$java_tmp_dir $gatk \
	-T BaseRecalibrator \
	-R $ref_genome \
	-I $1 \
	$interval \
	-nct $cpu_thread_num \
	-knownSites $data_path/ncbi/dbsnp/All_20150605.vcf.gz \
	-knownSites ${vcf_path}Mills_and_1000G_gold_standard.indels.${genome_assembly}.vcf \
	-knownSites ${vcf_path}1000G_phase1.indels.${genome_assembly}.vcf \
	-o $out_prefix.realn.recal_1.table


echo
echo gatk PrintReads nct $cpu_thread_num recommand nct 4"-"8 mem 4
java $j_mem -jar $gatk \
	-T PrintReads \
	-R $ref_genome \
	-I $1 \
	$interval \
	-nct $cpu_thread_num \
	-BQSR $out_prefix.realn.recal_1.table \
	-o $out_prefix.realn.recal.bam


. $cmd_done

