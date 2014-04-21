#!/bin/sh

command_succeeded() {
  if [ $1 -eq 0 ]; then
    eval "$2=\"OK\""
  else
    eval "$2=\"FAIL\""
  fi
}

if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null |
   grep -q com.apple.pkg.CLTools_Executables; then
  echo "Xcode Command Line Tools already installed!" >&2
  xcode_installed="OK"
else
  echo "Installing Xcode Command Line Tools..." >&2
  xcode-select --install
  command_succeeded $? xcode_installed
fi

if test -e /usr/local/bin/pip; then
  echo "pip already installed!" >&2
  pip_installed="OK"
else
  echo "Installing pip..."
  sudo easy_install pip
  command_succeeded $? pip_installed
fi

if test -e /usr/local/bin/ansible; then
  echo "Ansible already installed!" >&2
  ansible_installed="OK"
else
  echo "Installing Ansible..."
  sudo pip install ansible
  command_succeeded $? ansible_installed
fi

if [ "$xcode_installed" = "OK" ] &&
   [ "$pip_installed" = "OK" ] &&
   [ "$ansible_installed" = "OK" ]; then
  echo "Starting ansible provisioning..." >&2
  ansible-playbook site.yml -i hosts_inventory --skip-tags "debug"
else
  echo "Some required packages were not installed:" >&2
  echo "Xcode Command Line Tools... $xcode_installed" >&2
  echo "pip... $pip_installed" >&2
  echo "Ansible... $ansible_installed" >&2
fi


# Unset functions
unset -v xcode_installed
unset -v pip_installed
unset -v ansible_installed
unset -f command_succeeded
