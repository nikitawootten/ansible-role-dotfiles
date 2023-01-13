#!/usr/bin/env bash

# clear previous test output
mkdir -p tests/test_output
rm -fr tests/test_output/*

# hacky, symlink this role to the roles/ folder
ln -sf $(pwd) tests/roles/nikitawootten.dotfiles

(
    cd tests
    ansible-playbook -i hosts test.yml
)
