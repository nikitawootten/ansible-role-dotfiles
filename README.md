# Dotfiles

An Ansible role that mimics [GNU Stow](https://www.gnu.org/software/stow/), allowing for easy dotfiles management.

## Requirements

This role acts as a symlink farm.
Ensure that the target filesystem supports symlinks.
Additionally, this role is meant only for local provisioning.

This module is confirmed working on MacOS and Linux, but it has not been tested on Windows (please PR me if you do!).

## Role Variables

- `dotfiles_src`: The source folder (relative to the calling role/play) that files will be symlinked from/

  This defaults to the `files/` directory of the calling parent role.

- `dotfiles_dest`: The destination folder to put the symlinks.

  This defaults to the user's home directory.

- `dotfiles_mode`: If specified, this will set the permissions on linked files and created directories.
- `dotfiles_owner`: If specified, this will set the user on all linked files and intermediate directories.
- `dotfiles_group`: If specified, this will set the group on all linked files and intermediate directories.
- `dotfiles_become`: If set to true, all file operations will be run as root.

  **WARNING: Symlinks from unprivileged locations to privileged locations can introduce vulnerabilities into your environment. Proceed with caution**

For more details, see [`argument_specs.yaml`](./meta/argument_specs.yaml).

## Dependencies

None

## Example Playbook

This module is meant to be called from an [Ansible Role](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html).

Given a playbook with the following rough structure:

```
playbook.yaml
roles/
├─ important_config_files/
│  ├─ tasks/
│  │  ├─ main.yaml
│  ├─ files/
│  │  ├─ .important_config_file
```

Our play will import the `important_config_files` role:

```yaml
# playbook.yaml
---
- name: Test Ansible Play
  hosts: localhost
  roles:
    - important_config_files
```

Our role only needs to include the dotfiles role:

```yaml
# roles/important_config_files/tasks/main.yaml
- name: Symlink all my dotfiles
  ansible.builtin.include_role:
    name: nikitawootten.dotfiles
```

Upon running the playbook, all files inside the `files/` folder of the role (in our case, just `.important_config_file`) will be symlinked to the user's home.

## License

MIT

## Author Information

This role was created in 2023 by [Nikita Wootten](nikita.computer).
