# Bashrc
##Custom Bash Environment Setup
A streamlined script to automate the configuration of a productive Linux terminal environment. This script installs essential tools, sets up a custom visual PS1 prompt with distro-specific icons, and manages a local Python virtual environment.

##🚀 Features

###Auto-Package Installation: Detects your package manager (apt or dnf) and installs neofetch, git, gh, tree, and more.

###Custom Prompt: A multi-line, color-coded PS1 prompt that includes:

###Current username and hostname.

###Dynamic distro icons (Ubuntu, Arch, Fedora, Debian, Kali, etc.).

###Current working directory.

##Smart Aliases:

###ls and grep with auto-coloring.

###Navigation shortcuts like .. and ....

###Git shortcuts (gst, gp).

###Universal updater command based on your distro.

###Python Integration: Automatically creates and manages a virtual environment (~/.venv) with a pyven alias for quick activation.

###Safety First: Creates a timestamped backup of your existing .bashrc before making any changes.

##🛠️ Installation
###Clone the repository:

###Bash
'git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git'
'cd YOUR_REPO_NAME'
###Make the script executable:

###Bash
'chmod +x bash-setup.sh'

###Run the script:

###Bash
'./bash-setup.sh'

###Reload your configuration:

###Bash
'source ~/.bashrc'

##📋 Included Tools
###The script ensures the following are available on your system:

###neofetch (System Info)

###git & gh (Version Control)

###nano (Text Editor)

###wget & curl (Data Transfer)

###tree (Directory Visualization)

##🐍 Python Environment
###The script sets up a virtual environment at ~/.venv. If the directory already exists, the script will ask if you'd like to reinstall it.

###Activate: Use the alias pyven.

###Python 3: The alias python is mapped to python3.
