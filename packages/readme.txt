# Instalar pacotes oficiais
   - sudo pacman -S --needed - < pacman.txt
   - sudo pacman -S --needed $(cat pacman.txt)


# Instalar AUR   
   - yay -S --needed - < aur.txt
   - yay -S --needed $(cat aur.txt)


# instalar flatpak
   - xargs -a flatpaks.txt flatpak install -y

O pacman -Qqe vai salvar tudo que você instalou,
inclusive coisas que talvez você não queira em uma instalação limpa.
