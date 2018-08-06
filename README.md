
# yfull

## install

### 需要的工具
#### 以下工具应该在命令的搜索路径中
－ python，版本 2.7，版本 >= 3 不能保证正常运行
－ pip，python 包管理工具 pip
如何安装 pip 请见 https://pip.pypa.io/en/stable/installing/
简而言之，安装 pip 命令如下：
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
--user 在非管理员权限下安装
－ fastp
－ fastqc
－ bwa
－ samtools
#### 需要以下 jar 包
－ picard
－ gatk，目前仅支持版本 3

### 安装步骤
1. 推荐在虚拟环境下安装，首先安装 virtualenv
pip install --user virtualenv
2. 建立虚拟环境
virtualenv a_virtual_env
. a_virtual_env/bin/activate

3. 安装程序脚本
pip install git+https://gitee.com/yingnn/cal.git

4. 运行命令
yful --help

## 需要的文件和规定
### reference genome
参考基因组使用 GRCh38，即染色体命名没有前缀 ‘Chr’，使用 1-22，X，Y
共 24 个 contig，其他弃用，最后加上 rCRS。
参考基因组建立索引
ref_index.sh ref.fasta

### Indel realignment standard
从 gatk 获得的 vcf 文件
### Base quality score recalibration
从 gatk 获得的 vcf 文件


