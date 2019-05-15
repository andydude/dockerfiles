#!/usr/bin/env python
import argparse
import os
import sys


def append_path_segment(results, segment):
    if not segment in results:
        results += [segment]

        
def read_segment(segment):
    segment = segment.strip()
    segment = segment.replace("'", "\\'")
    segment = segment.replace('"', '\\"')
    segment = segment.replace('$', '\\$')
    return segment


def fts_read(paths):
    for filepath in paths:
        if os.path.isdir(filepath):
            dirpath = filepath
            for _, _, files in os.walk(dirpath):
                for filepath in files:
                    filepath = os.path.join(dirpath, filepath)
                    yield filepath
        else:
            yield filepath

            
def construct_path(var, paths):
    results = []
    for filepath in fts_read(paths):
        with open(filepath) as ent:
            for line in ent.readlines():
                segment = read_segment(line)
                append_path_segment(results, segment)

    return ':'.join(results)


def add_arguments(parser):
    parser.add_argument('--sh', '-s', action='store_true')
    parser.add_argument('--csh', '-c', action='store_true')
    parser.add_argument('--envvar', '-e', default='PATH', action='store')
    parser.add_argument('--parts', '-p', action='store_true')
    parser.add_argument('files', nargs=argparse.REMAINDER)
    return parser


def handler(sh, csh, parts, envvar, files):
    if not len(files):
        if envvar == 'PATH':
            files = ["/etc/paths", "/etc/paths.d"]
        elif envvar == 'MATHPATH':
            files = ["/etc/manpaths", "/etc/manpaths.d"]

    path = construct_path(envvar, files)

    if parts:
        print(path)
    elif csh:
        print("setenv {envvar} \"{path}\";\n".format(
            envvar=envvar, path=path))
    else:
        print("{envvar}=\"{path}\"; export {envvar};\n".format(
            envvar=envvar, path=path))


if __name__ == '__main__':
    parser = add_arguments(argparse.ArgumentParser())
    options = parser.parse_args(sys.argv[1:])
    handler(**vars(options))
