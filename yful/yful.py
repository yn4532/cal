from __future__ import print_function, division
import os
from .utils import get_abs, get_config, proc

RC = 'YFUL_RC'


def get_rc():
    if RC in os.environ.keys():
        return os.environ[RC]
    return get_abs('~/.config/yfulrc')


def format_java_run(mem='12g', tmp_dir='tmp'):
    # return 'java -Djava.io.tmpdir=%s -Xmx%s' % (tmp_dir, mem)
    return 'java.sh -d%s -m%s' % (tmp_dir, mem)


def format_indel_std(ini_file, indel_realign='indel_realignment'):
    config = get_config(ini_file)
    indel_std = config[indel_realign].values()
    indel_std = ['-known %s' % i for i in indel_std]
    indel_std = ' '.join(indel_std)
    return indel_std


def format_bqsr(ini_file, bqsr='bqsr'):
    config = get_config(ini_file)
    bqsr_std = config[bqsr].values()
    bqsr_std = ['-knownSites %s' % i for i in bqsr_std]
    bqsr_std = ' '.join(bqsr_std)
    return bqsr_std


def format_gatk(gatk, gatk_version):
    if int(gatk_version) == 3:
        return '%s -T' % gatk
    return gatk


def format_config(ini_file):
    general_label = 'general'
    rf_file = get_rc()
    conf = get_config(ini_file)
    # conf = conf.defaults()
    conf = conf[general_label]
    conf = dict(conf)
    print(conf)
    # mem = conf.pop('java_memery')
    # tmp = conf.pop('java_tmp_dir')
    mem = conf['java_memory']
    tmp = conf['java_tmp_dir']
    java_run = format_java_run(mem, tmp)

    gatk = format_gatk(conf['gatk'], conf['gatk_version'])
    conf['gatk'] = gatk

    conf['java_run'] = java_run
    conf['indel_std'] = format_indel_std(ini_file)
    conf['bqsr_std'] = format_bqsr(ini_file)
    with open(rf_file, 'wb') as f:
        for k, v in conf.items():
            # v = get_abs(v)
            if v.find(' ') != -1:
                v = '"%s"' % v
            f.write('%s=%s\n' % (k, v))


def cat(out_file, files=None):
    files_ = []
    for f in files:
        f = get_abs(f)
        with open(f, 'rb') as f_:
            files_.extend(f_.readlines())

    # print files_
    with open(out_file, 'wb') as f:
        f.writelines(files_)


def get_sh_utils(name_utils='utils.sh'):
    utils, _ = proc(['which', name_utils])
    print(utils)
    return utils


def cat_rc_utils(ini_file):
    format_config(ini_file)
    utils = get_sh_utils()
    rc = get_rc()
    with open(rc, 'a') as f:
        f.write('. %s\n' % utils)
