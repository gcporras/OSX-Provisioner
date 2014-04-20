#!/bin/sh

if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null | grep -q com.apple.pkg.CLTools_Executables; then
  echo "Xcode Command Line Tools already installed!" >&2
else
  echo "Installing Xcode Command Line Tools..." >&2
  xcode-select --install
fi

if test -e /usr/local/bin/pip; then
  echo "pip already installed!" >&2
else
  echo "Installing pip..."
  sudo easy_install pip
fi

if test -e /usr/local/bin/ansible; then
  echo "Ansible already installed!" >&2
else
  echo "Installing Ansible..."
  sudo pip install ansible
fi

echo "Starting ansible provisioning..." >&2
ansible-playbook site.yml -i hosts_inventory --skip-tags "debug"
