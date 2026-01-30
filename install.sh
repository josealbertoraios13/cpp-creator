# if any command returns an error, the script stops
set -e

# creates a directory where will be installed this program
mkdir -p "$HOME/cpp_creator"
cp -r ./* "$HOME/cpp_creator"

# Get the exact path to this script and store it in a variable.
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Go to home directory
cd "$HOME"

# Delete the installation directory.
rm -rf $SCRIPT_DIR

# Allows this file to be executed.
chmod +x "cpp_creator/alcpp.sh"

mkdir -p ".local/bin"

# Create a symbolic link so 'alcpp' can be run as a global command
# -s: symbolic, -f: force overwrite if exists
ln -sf "cpp_creator/alcpp.sh" ".local/bin/alcpp"

# Detect the active shell to determine the correct configuration file
case "$(basename "$SHELL")" in
    zsh)  
        RC=".zshrc" 
        ;;
    bash) 
        RC=".bashrc" 
        ;;
    fish)
        # Fish shell uses a specific directory structure for its configuration.
        RC=".config/fish/config.fish"
        ;;
    *)
        # Generic fallback for other shells (sh, dash, etc.)    
        RC=".profile" 
        ;;
esac

# Check if ".local/bin" is already in the config file.
# grep -q: quiet mode (returns exit status without printing output).
# !: logical NOT (proceeds if the string is NOT found).
if ! grep -q ".local/bin" "$RC"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC"
fi

# Check if the installation was successful.
if [ -e ".local/bin/alcpp" ]; then
    echo -e "Installation completed successfully. \nUse alcpp --help to view the available commands."
else
    echo "The installation failed."
fi