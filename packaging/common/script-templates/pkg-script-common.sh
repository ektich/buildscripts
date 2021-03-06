#!/bin/sh

#
# Detect and replace non-POSIX shell
#
try_exec() {
    type "$1" > /dev/null 2>&1 && exec "$@"
}

broken_posix_shell()
{
    unset foo
    local foo=1
    test "$foo" != "1"
}

if broken_posix_shell >/dev/null 2>&1; then
    try_exec /usr/xpg4/bin/sh "$0" "$@"
    echo "No compatible shell script interpreter found."
    echo "Please find a POSIX shell for your system."
    exit 42
fi

PREFIX=/var/cfengine

package_type()
{
  echo pkg
}

os_type()
{
  echo solaris
}

rc_d_path()
{
  echo "/etc"
}

rc_start_level()
{
  echo S97
}

rc_kill_level()
{
  echo K05
}

platform_service()
{
  /etc/init.d/"$1" "$2"
}

is_upgrade()
{
  # There is no such thing with the pkg manager.
  return 1
}
