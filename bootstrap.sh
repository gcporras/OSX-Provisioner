#!/bin/sh
# file: bootstrap.sh

_install_tool()
{
  if [ $# -ne 3 ]; then
    local E_BADARGS=65
    echo "USAGE: `basename $0` tool_name cmd_check_installed install_cmd"
    return $E_BADARGS
  else
    eval "$2"
    if [ $? -eq 0 ]; then
      echo "$1 already installed!"
      return 0
    else
      echo "Installing $1..."
      eval "$3"
      return $?
    fi
  fi
}

bootstrap()
{
  local XCODE_INSTALLED=pkgutil --pkg-info=com.apple.pkg.CLTools_Executables \
                        2>/dev/null | grep -q com.apple.pkg.CLTools_Executables

  _install_tool "Xcode CLT" "${XCODE_INSTALLED}" "xcode-select --install"
  local xcode_ok=$?
  _install_tool "Pip" "test -e /usr/local/bin/pip" "sudo pip install ansible"
  local pip_ok=$?
  _install_tool "Ansible" "test -e /usr/local/bin/ansible" "sudo pip install ansible"
  local ansible_ok=$?

  if [ ${xcode_ok} -eq 0 ] && [ ${pip_ok} -eq 0 ] && [ ${ansible_ok} -eq 0 ]; then
    echo "Starting ansible provisioning..."
    ansible-playbook site.yml -i hosts_inventory --skip-tags "debug"
  else
    echo "Some required packages were not installed! Please fix this."
  fi
}


###################################
# Main Script Logic Starts Here   #
###################################
case "$1" in
        install)
                bootstrap
                #Unset functions
                unset -f _install_tool
                unset -f bootstrap
                ;;
        test)
                # Used in the test suite. Avoid executing code
                ;;
        *)
                echo "Usage: $0 {install|test}"
                echo ""
                echo "Use this shell script to provision from scratch."
esac
