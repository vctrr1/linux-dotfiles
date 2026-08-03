KDE Plasma Backup

kdeglobals
------------
Configuração geral do KDE.
Guarda:
- tema global
- cores
- fontes
- ícones
- estilo visual


kglobalshortcutsrc
------------
Atalhos globais do KDE.
Guarda:
- atalhos personalizados
- atalhos do sistema
- combinações de teclas


kcminputrc
------------
Configuração de entrada.
Guarda:
- mouse
- touchpad
- velocidade
- aceleração


kxkbrc
------------
Configuração do teclado.
Guarda:
- layout
- idioma
- opções do teclado


kwinrc
------------
Configuração do gerenciador de janelas KWin.
Guarda:
- compositor
- efeitos
- animações
- comportamento das janelas


kwinrulesrc
------------
Regras específicas de janelas.
Exemplo:
- abrir Firefox sempre no monitor X
- tamanho fixo de uma aplicação


kwinoutputconfig.json
------------
Configuração dos monitores.
Guarda:
- saída de vídeo
- configuração do KWin para displays


plasma-org.kde.plasma.desktop-appletsrc
------------
Layout do Plasma.
Guarda:
- painéis
- widgets
- barra de tarefas
- posição dos elementos


plasmarc
------------
Configuração do Plasma.
Guarda:
- estilo do Plasma
- configurações visuais


plasmashellrc
------------
Configuração do shell do Plasma.


kscreen/ ~ salvo em ~/.local/share/kscreen o resto é em .config
------------
Configuração física dos monitores.
Guarda:
- resolução
- posição
- escala


kdeconnect/
------------
Configuração do KDE Connect.
Guarda:
- dispositivos pareados
- integração com celular


dolphinrc
------------
Configuração do Dolphin.
Guarda:
- modo de visualização
- painéis
- comportamento do gerenciador de arquivos


spectaclerc
------------
Configuração do Spectacle.
Guarda:
- atalhos de captura
- preferências de screenshot


katerc / katevirc
------------
Configuração do Kate.
Guarda:
- tema
- plugins
- comportamento do editor



comando para copiar os arquivos
cp ~/.config/kdeglobals .
cp ~/.config/kglobalshortcutsrc .
cp ~/.config/kcminputrc .
cp ~/.config/kxkbrc .
cp ~/.config/kwinrc .
cp ~/.config/kwinrulesrc .
cp ~/.config/kwinoutputconfig.json .
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc .
cp ~/.config/plasmarc .
cp ~/.config/plasmashellrc .
cp ~/.config/plasma-localerc .
cp ~/.config/kscreenlockerrc .
cp ~/.config/powerdevilrc .
cp ~/.config/powermanagementprofilesrc .
cp ~/.config/dolphinrc .
cp ~/.config/spectaclerc .
cp ~/.config/katerc .
cp ~/.config/katevirc .
cp -r ~/.config/kdeconnect .
cp -r ~/.local/share/kscreen .
