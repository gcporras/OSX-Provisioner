local-provisioning-ansible-osx
==============================

Repository for provisioning my osx machine.
To install from scratch. Run the command:

    source bootstrap.sh

If Xcode Command Line Tools and Ansible are already installed, you can run the command:

    ansible-playbook site.yml -i hosts_inventory --tags "<tag_names>"

List of tags:
- debug: For debugging purposes.
- homebrew: Install homebrew and the list of brews provided.

###TODO:
- List of pre-requirements (or script to install them).
  https://devopsu.com/guides/ansible-mac-osx.html
- Read yml file with list of brews to install.
- Brew-cask integration.
- zsh and my fork of prezto.
- Dotfiles integration.
- export some roles to ansible-galaxy.
