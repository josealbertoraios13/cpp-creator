set -e


mkdir -p ~/cpp_creator
cp -r ./* ~/cpp_creator

chmod +x ~/cpp_creator/alcpp.sh

mkdir -p ~/.local/bin
ln -sf ~/cpp_creator/alcpp.sh ~/.local/bin/alcpp

case "$(basename "$SHELL")" in
    zsh)  
        RC="$HOME/.zshrc" 
        ;;
    bash) 
        RC="$HOME/.bashrc" 
        ;;
    *)    
        RC="$HOME/.profile" 
        ;;
esac

echo "$RC"

if ! grep -q "$HOME/.local/bin" "$RC"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC"
fi

if [ -e ~/.local/bin/alcpp ]; then
    echo -e "*****\nAfter installation, you can delete this folder."
else
    echo "Erro"
fi

which alcpp