# Ansible Playbook: Setup OSX/iOS CI Environment

![GPL-3.0 licensed][badge-license]
[![Build Status](https://travis-ci.org/macstadium/ansible-playbook-osx-ci-setup.svg?branch=master)](https://travis-ci.org/macstadium/ansible-playbook-osx-ci-setup)

This playbook uses two roles:

* [OSX-CI][osx-ci]
* [Xcode][xcode-role]

They setup a CI user and install and configure common tools used for OSX/iOS CI environment:

* [Homebrew][homebrew]
* [Node.js 10 LTS][node10]
* [Java 8][java8] - Jenkins requirement. By installing Java 8, the OSX machine can be easily become a Jenkins agent.
* [fastlane][fastlane]
* [CocoaPods][cocoapods]
* [Xcode][xcode]

The default role inventory targets `localhost` (found in [`inventory/main`](inventory/main)). This means that the playbook should be executed on the machine that needs to be configured.
If you want to execute the playbook remotely you need to provide another Ansible inventory. Detailed description what is an inventory and how to use it can be found in the [Ansible documentation][inventory]

## Requirements

The playbook requires [Ansible][ansible] to be installed on both the host and the target machine.
In the default setup the host and target machine are the same.
You can find a configuration bash script in [`scripts/ansible_setup.sh`](scripts/ansible_setup.sh).

Running

    sudo scripts/ansible_setup.sh

will install:
* Xcode Command Line Tools
* pip
* Ansible

Both roles come from [Ansible Galaxy][galaxy]. In order to install them you need to run:

    ansible-galaxy install -r requirements.yml

The Xcode Command Line Tools and Xcode installations require a UI session. This means the user you are using to execute the playbook must be logged on to the OSX machine.

## Variables

The playbook will need several variables in order to work correctly. Their default values can be found in [`group_vars/all.yml`](group_vars/all.yml).

    ansible_user: admin

The default user name to use for installing and configuring the needed tooling.

    ansible_become_pass

The privilege escalation password. It is highly recommended not to pass the password in plain text.
To encrypt it we will use [Ansible Vault][vault].
You can add the variable to [`group_vars/all.yml`](group_vars/all.yml) and execute the following command:

    ansible-vault encrypt group_vars/all.yml

You will be asked for a vault password. It will be later used to decrypt the file.
Once the operation is executed the file will be encrypted.
Then you can run `ansible-playbook` with the `--ask-vault-pass` flag. You will be asked for the vault password you used to encrypt the file.
Once the vault password is submitted the playbook will continue its execution.
More on Ansible Vault can be found [here][vault].

For information about the variables that `osx-ci` and `xcode` roles expect you can check their repositories:

* [OSX-CI][osx-ci]
* [Xcode][xcode-role]

## Dependencies

None.

## Example

    ansible-playbook site.yml -i inventory -e ansible_user=administrator -e xcode_xip_location='/Users/administrator/Downloads/Xcode_10.1.xip' -e xcode_major_version=10 -e ci_user_public_key_location='/tmp/ci_user.pub' --ask-vault-pass

## License

[GPL-3.0][link-license]

## Author Information

This playbook was created in 2019 by [MacStadium, Inc][macstadium].

#### Maintainer(s)

- [Ivan Spasov](https://github.com/ispasov)

[macstadium]: https://www.macstadium.com/
[ansible]: https://docs.ansible.com/ansible/2.4/index.html
[galaxy]: https://galaxy.ansible.com/
[vault]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html
[inventory]: https://docs.ansible.com/ansible/2.4/intro_inventory.html
[badge-license]: https://img.shields.io/badge/License-GPL3-green.svg
[link-license]: https://raw.githubusercontent.com/macstadium/ansible-playbook-osx-ci-setup/master/LICENSE
[homebrew]: https://brew.sh/
[node10]: https://nodejs.org/en/blog/release/v10.13.0/
[java8]: https://www.oracle.com/technetwork/java/javase/overview/java8-2100321.html
[fastlane]: https://fastlane.tools/
[cocoapods]: https://cocoapods.org/
[xcode]: https://developer.apple.com/xcode/
[osx-ci]: https://galaxy.ansible.com/macstadium/osx_ci
[xcode-role]: https://galaxy.ansible.com/macstadium/xcode