#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'g.vcf.list'
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


list=$1
test -n "$interval" && interval='-L $interval'

# CombineGVCFs # run CombineGVCFs on batches of ~200 gVCFs to hierarchically merge them into a single gVCF

echo; echo CombineGVCFs
java.sh -m$java_memory -d$java_tmp_dir $gatk \
    CombineGVCFs $interval \
    -R $ref_genome \
    --variant $list \
    -o $out_prefix.combine.g.vcf


. $cmd_done
