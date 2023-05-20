# ansible
Ansible playbooks for common tasks

## Running setup

1. Run the ansible setup script,  This script makes sure that you have everything ready to run ansible.  If you have nothing installed, it takes about 5 to 10 minutes (mostly installing `homebrew`).  

```bash
sh scripts/setup-ansible.sh
```

2. (OSX) After the script runs, add the following to your ~/.zprofile:

```bash
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Running ansible


### One-time Setup
If the playbook has a `requirements.yml` file, install them

```bash
ansible-galaxy install -r base/requirements.yml
```

### Full
Run this command from within the playbook directory
```bash
ansible-playbook -i inventory main.yml
```
