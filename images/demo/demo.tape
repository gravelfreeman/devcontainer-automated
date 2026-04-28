Output images/demo.gif

Require bash

Set Shell "bash"
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set FontSize 36
Set Width 2000
Set Height 250
Set Padding 36
Set Theme { "background": "#232634", "foreground": "#dddddd", "cursor": "#dddddd", "cursorAccent": "#171717", "black": "#282a2e", "brightBlack": "#4d4d4d", "red": "#D74E6F", "brightRed": "#FE5F86", "green": "#31BB71", "brightGreen": "#00D787", "yellow": "#D3E561", "brightYellow": "#EBFF71", "blue": "#03B0FC", "brightBlue": "#03B0FC", "magenta": "#ED61D7", "brightMagenta": "#FF7AEA", "cyan": "#04D7D7", "brightCyan": "#00FEFE", "white": "#bfbfbf", "brightWhite": "#e6e6e6" }
Set TypingSpeed 85ms
Set Framerate 30
Set CursorBlink true

Hide
Type "workdir=$(mktemp -d)/my-project"
Enter
Type `mkdir -p "$workdir"`
Enter
Type `cd "$workdir"`
Enter
Type "shopt -s expand_aliases"
Enter
Type "devcontainer_automated_state=0"
Enter
Type "clear_previous_line() {"
Enter
Type `printf '\033[1A\r\033[2K'`
Enter
Type "}"
Enter
Type "devcontainer_automated() {"
Enter
Type 'if [[ "${devcontainer_automated_state}" -eq 0 ]]; then'
Enter
Type `printf "%s" "Do you want to initialize a devcontainer in this project folder? [y/N] "`
Enter
Type "IFS= read -r _"
Enter
Type "clear_previous_line"
Enter
Type `printf "%s" "Enter GitHub username to use a custom template, or blank for defaults: "`
Enter
Type "IFS= read -r _"
Enter
Type "clear_previous_line"
Enter
Type `printf '%s\n' '[info] Initializing my-project with custom template from freeman'`
Enter
Type "sleep 0.5"
Enter
Type `printf '%s\n' '[info] Success: my-project is initialized'`
Enter
Type "devcontainer_automated_state=1"
Enter
Type "else"
Enter
Type `printf '%s\n' '[info] Starting 1Password SSH agent proxy'`
Enter
Type "sleep 0.5"
Enter
Type `printf '%s\n' '[info] Starting existing devcontainer'`
Enter
Type "sleep 0.5"
Enter
Type `printf '%s\n' '[info] Opening VS Code in devcontainer'`
Enter
Type "sleep 0.5"
Enter
Type `printf '%s\n' '[info] Dropping current shell in devcontainer'`
Enter
Type "sleep 4"
Enter
Type "clear"
Enter
Type `export PS1=$'\[\e[32m\]vscode ➜ /workspaces/my-project \[\e[39m\](main) $ '`
Enter
Type "fi"
Enter
Type "}"
Enter
Type "alias devcontainer-automated=devcontainer_automated"
Enter
Type `export PS1=$'\[\e[34m\]~/../my-project \[\e[39m\] \[\e[34m\]main \[\e[39m\] '`
Enter
Type "clear"
Enter
Show

Type "devcontainer-automated"
Sleep 800ms
Enter
Wait+Screen /\[y\/N\]/
Sleep 5s
Type@120ms "y"
Sleep 1s
Enter
Wait+Screen /Enter GitHub username to use a custom template/
Sleep 5s
Type@120ms "freeman"
Sleep 1s
Enter
Wait+Screen /\[info\] Success: my-project is initialized/
Sleep 3s

Type "devcontainer-automated"
Sleep 800ms
Enter
Wait+Screen /\/workspaces\/my-project \(main\)/
Sleep 1200ms

Type@75ms "You're now in your devcontainer!"
Sleep 3s
