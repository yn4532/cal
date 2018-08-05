#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'g.vcf'
exit 1
}

while getopts  ":p:f:i:" opt; do
	case  $opt  in
		p) out_prefix=$OPTARG;;
		f) suffix=$OPTARG;;
        i) interval=$OPTARG;;
		*) info;;
	esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi

. $var

test -n "$interval" && interval="-L $interval"

# CombineGVCFs # run CombineGVCFs on batches of ~200 gVCFs to hierarchically merge them into a single gVCF

echo; echo GenotypeGVCFs
java.sh -m$java_memory -d$java_tmp_dir $gatk \
    GenotypeGVCFs \
    -R $ref_genome $interval\
    --variant $1 \
    -o $out_prefix.gt.vcf \
    -nt 4 \
    --useNewAFCalculator \
    -stand_call_conf 20


. $cmd_done



