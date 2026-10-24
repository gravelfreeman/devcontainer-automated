<p align="center">
  <img src="./devcontainer-automated.png" width="280">
</p>

# devcontainer-automated

`devcontainer-automated` is a lightweight CLI for managing repo-specific
Dev Containers: create or start them, rebuild them when their configuration
changes, and open an interactive shell.

It provides a clean, but *opinionated* **Linux** development workflow with **Git** and **OpenCode** for editors such as **Zed**. Tools running inside the devcontainer can use **1Password**’s interactive host prompts for SSH access and `op` secret retrieval.

### What it does

- creates or starts the project devcontainer
- opens a `zsh` shell in the running container
- reuses existing containers until `rebuild` is requested
- configures SSH and Git through **1Password**
- exposes **OpenCode** inside the container

<img width="806" height="606" alt="devcontainer-automated-demo" src="https://github.com/user-attachments/assets/4ae00a9d-9765-40fd-8c9a-08100fac944e" />

## Requirements

- 1Password desktop app with the SSH agent enabled
- 1Password CLI at `/usr/bin/op`
- OpenCode at `/usr/bin/opencode`
- `devcontainer` CLI
- Docker

## Install

```bash
install -m 0755 devcontainer-automated ~/.local/bin/devcontainer-automated
```

Run it from a project directory:

```bash
devcontainer-automated
```

## Usage

Run the script from the root of your project:

```text
devcontainer-automated [options] [command]
```

### Commands

| Command | Description |
| --- | --- |
| *(none)* | Create or start the container, then open `zsh`. |
| `init` | Download and copy the current `.devcontainer` template. |
| `up` | Create or start the container without opening a shell. |
| `shell` | Open `zsh` in the running container. |
| `rebuild` | Remove and recreate the container, then open `zsh`. |

### Flags

| Option | Description |
| --- | --- |
| `--debug` | Enable debug logs. |
| `--help` | Show the help message. |
| `--workspace <path>` | Use another workspace directory. |

## Template

Run `devcontainer-automated init` in a project without a `.devcontainer`
directory to download the current template from this repository.

The template uses the Linux host paths directly:

- `~/.1password` → `/home/vscode/.1password`
- `~/.gitconfig` → `/tmp/host.gitconfig`
- `/run/user` → `/run/host-runtime`
- `/usr/bin/op` → `/usr/bin/op`
- `/usr/bin/opencode` → `/usr/bin/opencode`
- `~/.config/opencode` → `/home/vscode/.config/opencode`
- `~/.local/share/opencode` → `/home/vscode/.local/share/opencode`
- `~/.local/state` → `/home/vscode/.local/state`

On creation, the container:

- initializes the 1Password app socket
- retrieves `GitHub Auth Key` with `op`
- creates `~/.ssh/github-auth.pub`
- configures GitHub SSH access and local `known_hosts`
- configures Git SSH signing with `ssh-keygen`
- marks the workspace as a Git `safe.directory`

## Opinionated choices

This project is intentionally built around a few personal choices:

- **Linux**: Windows and macOS involves too many compromises and workarounds.
- **1Password**: No FOSS alternative currently has a comparable feature set.
- **OpenCode**: Connects to my LLM/MCP gateway so I can switch providers freely.
- **Docker**: The simplest fit for my local homelab context.
