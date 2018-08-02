from __future__ import print_function, division
import os
from .utils import get_abs, get_config, proc

RC = 'YFUL_RC'


def get_rc():
    if RC in os.environ.keys():
        return os.environ[RC]
    return get_abs('~/.config/yfulrc')


def format_java_run(mem='12g', tmp_dir='tmp'):
    return 'java -Djava.io.tmpdir=%s -Xmx%s' % (tmp_dir, mem)


def format_config(ini_file):
    rf_file = get_rc()
    conf = get_config(ini_file)
    conf = conf.defaults()
    print(conf)
    mem = conf.pop('java_memery')
    tmp = conf.pop('java_tmp_dir')
    java_run = format_java_run(mem, tmp)
    conf['java_run'] = java_run
    with open(rf_file, 'wb') as f:
        for k, v in conf.items():
            v = get_abs(v)
            f.write('%s="%s"\n' % (k, v))


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
