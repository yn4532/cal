
# yfull

## install

## 需要的文件和规定
参考基因组使用 GRCh38，即染色体命名没有前缀 ‘Chr’，使用 1-22，X，Y
共 24 个 contig，其他弃用，最后加上 rCRS。


## 需要的工具
fastp
fastqc
bwa
samtools
picard
gatk

## 用法
首先确保使用 bwa samtools picards 对参考基因组索引。

接下来使用命令：
yful --config config -sample_name --r1 --r2 --interval --prefix

## 结果查看
$prefix.yfull.txt
