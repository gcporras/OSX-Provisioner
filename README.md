OSX-Provisioner
===============

Repository for provisioning my osx machine.
To install from scratch, run the command:

    source bootstrap.sh install

If Xcode Command Line Tools and Ansible are already installed, you can run the command:

    ansible-playbook site.yml -i hosts_inventory --tags "<tag_names>"

List of tags:
- debug: For debugging purposes.
- homebrew: Install homebrew and the list of brews provided.

####Tests:
To run bootstrap tests (shunit2 is required):

   Zsh

    zsh -o shwordsplit -- test_bootstrap.sh

   Bash

    source test_bootstrap.sh

Note: To know if you terminal is bash or zsh. Use `echo $0`

### To do:
- [x] Script to install ansible [pre-requirements](https://devopsu.com/guides/ansible-mac-osx.html).
- [x] Install [homebrew](https://github.com/Homebrew/homebrew/wiki/Installation)
- [ ] Brew - playbook who reads from base yml and user local yml (privacy).
- [ ] Brew-cask integration.
- [ ] Travis or other CI - integration
- [ ] Set zsh as default shell and use my fork of prezto.
- [ ] Dotfiles integration.
