# Configuración para Zsh

### Descarga y copia el archivo `.zshrc` en tu directorio home:
```bash
curl -o ~/.zshrc https://github.com/DarthGexe/dotfiles/raw/main/.zshrc
```
### Requisitos:
- Tener Zsh configurado como shell predeterminado.
- Instalar [powerlevel10k](https://github.com/romkatv/powerlevel10k).

# Configuracion para neovim

### Crea el directorio si no existe
```bash
mkdir -p ~/.config/nvim
```
### Descarga y copia init.vim al directorio ~/.config/nvim
```bash
curl -o ~/.config/nvim/init.vim https://github.com/DarthGexe/dotfiles/raw/main/init.vim
```
### Requisito previo:
- Instalar [vim-plug](https://github.com/junegunn/vim-plug) para gestionar plugins.

Después de copiar el archivo:
- Abre Neovim: nvim
- Ejecuta :PlugInstall para instalar los plugins




