
# yfull

## 功能
- fastqc -- 质量控制
- fastp -- 质量控制，引物切除
- bwa mem -- 比对
- bam filter -- 低质量比对过滤
- bqsr -- 剪辑质量值校正
- haplotype caller and genotype caller -- 单倍体型和基因型检出

## 安装

### 需要的工具
#### 以下工具应该在命令的搜索路径中
- python，版本 2.7，版本 >= 3 不能保证正常运行
- pip，python 包管理工具 pip

如何安装 pip 请见 https://pip.pypa.io/en/stable/installing/

简而言之，安装 pip 命令如下：

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python get-pip.py --user

"--user" 在非管理员权限下安装
- fastp
- fastqc
- bwa
- samtools
#### 需要以下 jar 包
- picard
- gatk，目前仅支持版本 3

### 安装步骤
1. 推荐在虚拟环境下安装，首先安装 virtualenv

pip install --user virtualenv

2. 建立虚拟环境

virtualenv a_virtual_env

. a_virtual_env/bin/activate

需要注意的是，如果建立了虚拟环境，则每次运行程序时需要保证在虚拟环境下运行，通过 . a_virtual_env/bin/activate 实现。

3. 安装程序脚本

pip install git+https://github.com/yn4532/cal.git

4. 运行命令

yful --help

yful --config yful.cfg list

yful.cfg 是程序的配置文件，list 中是每行三列的文件，各列分别表示 sample_name path/to/read1.fq path/to/read2.fq，以 tab 分割

需要注意的是 yful.cfg 在第一次运行程序时和每次 yful.cfg 更改后需要经由 --config yful.cfg 使生效。

查看示例文件

git clone git@github.com:yn4532/cal.git

cd cal

ls ./examples/yful.cfg ./examples/list

## 需要的文件和规定
### reference genome
参考基因组使用 GRCh38，即染色体命名没有前缀 ‘Chr’，使用 1-22，X，Y
MT 共 25 个 contig，其他弃用。其中 MT id 为 NC_012920.1（即为rCRS？）。

参考基因组建立索引

ref_index.sh ref.fasta

### Indel realignment standard
从 gatk 获得的 vcf 文件
### Base quality score recalibration standard
从 gatk 获得的 vcf 文件

获取标准文件

download_std.sh &





