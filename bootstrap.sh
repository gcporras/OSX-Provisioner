#!/bin/sh

if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null | grep -q com.apple.pkg.CLTools_Executables; then
  echo "Xcode Command Line Tools installed!" >&2
  echo "Starting ansible provisioning..."
  ansible-playbook site.yml -i hosts_inventory --skip-tags "debug"
else
  xcode-select --install
fi
