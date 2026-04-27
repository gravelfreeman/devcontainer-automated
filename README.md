<p align="center">
  <img src="./images/devcontainer-automated.png" alt="devcontainer-automated logo" width="280">
</p>

# devcontainer-automated

`devcontainer-automated` is a macOS-only, opinionated helper script for people who want a nearly zero-config per-project devcontainer workflow without giving up host-native quality of life.

It lets you keep using your own terminal app, your host SSH agent, and the nice 1Password prompts, while opening VS Code directly in the right devcontainer and dropping your shell into that same container.

### What it does :

- One reusable workflow instead of project-specific glue commands
- Opens VS Code in a devcontainer, without "Reopen/Attach to Container" prompts
- Opens your host terminal into the same running container
- Keeps SSH working in both VS Code and your host shell, including 1Password prompts
- Automated rebuilds, only when needed *([Rebuild behavior](#rebuild-behavior))*

## Requirements

- A project directory that contains a `.devcontainer` folder
- [colima](https://formulae.brew.sh/formula/colima) installed and running, with working `ssh colima` setup
- [vscode](https://formulae.brew.sh/cask/visual-studio-code) application installed (`code` command)
- [devcontainer](https://formulae.brew.sh/formula/devcontainer) CLI installed (`devcontainer` command)
- [docker](https://formulae.brew.sh/formula/docker) CLI installed (`docker` command)

## Install

Make the script executable and put it on your `PATH`. For example:

```bash
chmod +x devcontainer-automated
mv devcontainer-automated ~/.local/bin/devcontainer-automated
```

Then start Colima:

```bash
colima start
```

## Usage

Run the script from the root of a project that has a `.devcontainer` directory:

```bash
devcontainer-automated [options] [command]
```

Commands:

- no command: create or start the devcontainer, open VS Code, then open a shell
- `code`: create or start the devcontainer, then open VS Code only
- `shell`: create or start the devcontainer, then open a shell only
- `rebuild`: force-remove the existing container, recreate it, open VS Code, then open a shell

Flags:

- `--user <user>`: container user used for the interactive shell, defaults to `vscode`
- `--shell <shell>`: shell command used for the interactive shell, defaults to `bash`
- `--workspace <path>`: use a workspace path instead of the current directory, defaults to `/workspaces/<project-folder>`
- `--debug`: enable debug logs

<details>
<summary>Advanced options</summary>

You can optionally pass a [1Password service account](https://developer.1password.com/docs/service-accounts/get-started/) token through `remoteEnv` to keep `op` authenticated inside the devcontainer, **but this is insecure and not recommended**.

- `--vault <vault>`: read `OP_SERVICE_ACCOUNT_TOKEN`
- `--token <token>`: pass a service account token directly

</details>


## Rebuild behavior

The script hashes the contents of the `.devcontainer` directory and stores that hash in a temp file.

In practice:

- if the container exists and the `.devcontainer` hash did not change, it reuses the container
- if the container is missing, it creates it
- if the `.devcontainer` hash changed, it recreates the container
- if you run `rebuild`, it recreates the container no matter what

This keeps the workflow fast while still reacting to real devcontainer config changes.

## Current implementation choices

Colima is a practical fit for this workflow today because it stays lightweight and focused on local container runtime needs, without the extra surface area of Docker Desktop. Contributions to make the script work cleanly with Docker Desktop or Apple Containers are welcome.

1Password is a practical fit for this workflow today because it is the SSH agent setup I'm currently using. Contributions to make the script work cleanly with SSH agents beyond 1Password are welcome.
