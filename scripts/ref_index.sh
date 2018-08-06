#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'ref.fa'
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

export YFUL_RC=~/.config/yfulrc
export var=$YFUL_RC
. $var

# ref=$1.$2

bwa index $1 &

samtools faidx $1 & # no need because aln2sam will return to based on b37.fa


# java -Xmx$java_memory -jar ${picard_path}CreateSequenceDictionary.jar \
# REFERENCE=$ref \
# OUTPUT=$1.dict \
# GENOME_ASSEMBLY=$3

# :<<noneed
# if exist a dict file; picard will do nothing.


if test -n "$picard_path"; then
    csd=$picard_path/CreateSequenceDictionary.jar
fi
if test -n "$picard"; then
    csd="$picard CreateSequenceDictionary"
fi

fa=`basename $1 .fq`
fa=`basename $fa .fastq`
fa=`dirname $1`/$fa

java.sh $csd \
REFERENCE=$1 \
OUTPUT=$fa.dict

# fa_pre=$(basename $1 .fa)
# fastq_pre=$(basename $1 .fasta)

# ln -fs $out_prefix.dict $fa_pre.dict
# ln -fs $out_prefix.dict $fastq_pre.dict

wait
# noneed

. $cmd_done
