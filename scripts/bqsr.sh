#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-t] [-i in.bed] in.bam
exit 1
}

while getopts  ":i:p:t:" opts
do
        case  $opts  in
		i) interval=$OPTARG;;
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
	BaseRecalibrator \
	-R $ref_genome \
	-I $1 \
	$interval \
	-nct $threads \
	$bqsr_std \
	-o $out_prefix.realn.recal_1.table


echo
echo gatk PrintReads nct $cpu_thread_num recommand nct 4"-"8 mem 4
java.sh -m$java_memory -d$java_tmp_dir $gatk \
	PrintReads \
	-R $ref_genome \
	-I $1 \
	$interval \
	-nct $threads \
	-BQSR $out_prefix.realn.recal_1.table \
	-o $out_prefix.bqsr.bam


. $cmd_done

