<h1 align="center" style="font-weight: bold;">FinalTouch</h1>

<p align="center">
  <a href="#tech">Tecnologias</a> • 
  <a href="#about">Sobre</a> •
  <a href="#started">Começando</a> • 
  <a href="#colab">Colaboradores</a> •
  <a href="#contribute">Contribuir</a>
</p>

<p align="center">
    <b>Este script automatiza a instalação de vários pacotes de software no Ubuntu 20.04 e Linux Mint 19.3.</b>
</p>

<h2 id="tech">Tecnologias</h2>

- [Bash Script](https://devdocs.io/bash)

<h2 id="about">Sobre</h2>

<p>Este script automatiza a instalação de vários pacotes de software no Ubuntu 20.04 e Linux Mint 19.3. Ele fornece uma interface interativa usando zenity para fácil seleção de software para instalar ou remover.</p>

<h3>Funcionalidades</h3>

- **Atualização do sistema:** Atualiza repositórios e pacotes instalados.
- **Instalação de software:** Instala vários softwares via APT, SNAP e FLATPAK.
- **Remoção de software:** Desinstala software pré-instalado selecionado.
- **Detecção de distribuição:** Detecta automaticamente se o sistema é Ubuntu ou Linux Mint.

<h2 id="started">Começando</h2>

1. **Clone este repositório:**

```bash
git clone https://github.com/vdonoladev/FinalTouch.git
```

2. **Navegue até o diretório do projeto:**

```bash
cd FinalTouch
```

4. **Execute o arquivo:**

- `sudo bash after-install.sh`

5. **Selecione uma opção:**

- Ao executar, um menu aparecerá com as seguintes opções:
  - Atualizar repositórios e sistema
  - Instalar programas
  - Desinstalar programas incorporados

6. **Instalar software:**

- Se você escolher "Instalar programas", verá uma lista de softwares disponíveis. Selecione os que deseja e o script os instalará.

7. **Desinstalar software:**

- Se você escolher "Desinstalar programas incorporados", selecione os aplicativos que deseja remover.

<h3>Pré-requisitos</h3>

- Certifique-se de ter o seguinte instalado antes de executar o script:

  - `zenity`
  - `lsb-release`
  - `flatpak`
  - `snapd`

- Para instalar as dependências:

  - ```sudo apt update && sudo apt install zenity lsb-release flatpak snapd -y

    ```

<h3>Softwares suportados</h3>

- Pacotes APT

  - `libreoffice`
  - `gparted`
  - `wine-stable`
  - `audacious`

- Pacotes Flatpak

  - `Spotify`
  - `Telegram`
  - `Discord`
  - `Handbrake`
  - `OnlyOffice`

- Aplicativos Snap

  - `VLC`
  - `WhatsApp Desktop`

- Pacotes Manuais

  - `Google Chrome`
  - `Insync`

<h3>Solução de Problemas</h3>

Se uma instalação falhar:

- Certifique-se de ter uma conexão ativa com a internet.
- Execute `sudo apt update` manualmente para verificar se há problemas.
- Verifique se o nome do pacote está correto e disponível para sua distribuição.

<h2 id="colab">Colaboradores</h2>

Agradecimento especial a todas as pessoas que contribuíram para este projeto.

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/vdonoladev.png" width="100px;" alt="Víctor Donola Ferreira Profile Picture"/><br>
        <sub>
          <b>Víctor Donola Ferreira</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

<h2 id="contribute">Contribuir</h2>

1. `git clone https://github.com/vdonoladev/FinalTouch.git`
2. `git checkout -b feature/NAME-OF-FEATURE`
3. Siga os **Commit Patterns**
4. Abra um **Pull Request** explicando o problema resolvido ou o recurso feito, se houver, anexe a captura de tela das modificações visuais e aguarde a revisão!

<h3>Documentações que podem ajudar</h3>

- [📝 How to create a Pull Request](https://www.atlassian.com/br/git/tutorials/making-a-pull-request)

- [💾 Commit pattern](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)
