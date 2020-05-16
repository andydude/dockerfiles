# path-helper implementations

Various implementations of Apple's `path_helper` tool.

## Python usage

The Python version will likely work in environments without a Bash shell, such as busybox or dash environments.

```
# Put in .profile
eval $(python path_helper.py -s)
```

## Bash usage

The Bash version may work with other shells, but it relies on advanced features such as arrays.

```
# Put in .profile
source path_helper.sh
eval $(path_helper)
```

## See also
- [Apple path-helper](https://opensource.apple.com/source/shell_cmds/shell_cmds-203/path_helper/path_helper.c.auto.html)
