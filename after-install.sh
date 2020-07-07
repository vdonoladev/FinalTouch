#!/bin/bash
# Escrito por Víctor Donola Ferreira (vdonoladev)


#---VARIÁVEIS---#
CHOICE=Softwares

# verifique se isso está sendo executado como root
declare -f VERIFY_ROOT
function VERIFY_ROOT()
{
	uid=$(id -ur)
	if [ "$uid" != "0" ]; then
	        echo "ERROR: Este script deve ser executado como root"
		if [ -x /usr/bin/sudo ]; then
			echo "try: sudo $0"
		fi
	        exit 1
	fi
}

#---IDENTIFICAR DISTRIBUIÇÃO---#
declare -f VERIFY_DISTRIB
function VERIFY_DISTRIB()
{
	ID=`lsb_release -i`
	RELEASE=`lsb_release -r`
	if [[ $ID = "Distributor ID:	Ubuntu" && $RELEASE = "Release:	20.04" ]]; then
		clear
		lsb_release -a
		MENU_UBUNTU
	elif [[ $ID = "Distributor ID:	LinuxMint" && $RELEASE = "Release:	19.3" ]]; then
		clear
		lsb_release -a
		MENU_MINT
	else	
		echo "#========== Distribuição não suportada ==========#"
		sleep 3

	fi
}

#--- Função de atualização do sistema ---#
declare -f UPDATE
function UPDATE()
{
	clear
	echo "=== Atualizando Repositórios ==="
	sleep 2
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
	sudo apt update -y
	clear
	echo "=== Aplicando Atualizações ==="
	sleep 2
	sudo apt dist-upgrade -y
	clear
	echo "=== Finalizado ==="
	sleep 3
	VERIFY_DISTRIB
}

#--- Functions ---#
declare -f INSTSOFTWARE
function INSTSOFTWARE()
{
	clear
	echo "#========== Instalando $CHOICE ==========#"
	sleep 2
	clear
	for CHOICE in $selection; do
		echo "#========== Instalando $CHOICE ==========#"
		sleep 2
		case $CHOICE in
			Google-Chrome-Stable )
				INSTCHROME
				;;
			Insync )
				INSTINSYNC
				;;
			Spotify-FlatHub )
				flatpak install flathub com.spotify.Client -y
				;;
			Sublime-Text-FlatHub )
				flatpak install flathub com.sublimetext.three -y
				;;
			Handbrake-FlatHub )
				flatpak install flathub fr.handbrake.ghb -y 
				;;
			WPS-Office-FlatHub )
				flatpak install flathub com.wps.Office -y
				;;
			ONLYOFFICE-FlatHub )
				flatpak install flathub org.onlyoffice.desktopeditors -y
				;;	
			Discord-FlatHub )
				flatpak install flathub com.discordapp.Discord -y
				;;	
			libreoffice )
				INSTLIBREOFFICE
				;;
			Telegram-FlatHub )
				flatpak install flathub org.telegram.desktop -y
				;;
			Tor-Browser-Launcher-FlatHub )
				flatpak install flathub com.github.micahflee.torbrowser-launcher -y
				;;
			Jdownloader-FlatHub )
				flatpak install flathub org.jdownloader.JDownloader -y
				;;		
			Whatsapp-desktop-Snap )
				sudo snap install whatsdesk
				;;
			Vlc )
				sudo snap install vlc
				;;			
			Unpackers )	
				sudo apt install p7zip-full p7zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress -y 
				;;	
			* )
				apt install $CHOICE -y 
				;;	
		esac		
	done 
	echo "#========== Concluído com sucesso! ==========#"
	sleep 3
    clear
    VERIFY_DISTRIB			
}

declare -f INSTCHROME
function INSTCHROME()
{
	mkdir /tmp/chrome
	cd /tmp/chrome
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i *.deb
}

declare -f INSTINSYNC
function INSTINSYNC()
{
	mkdir /tmp/insync
	cd /tmp/insync
	wget https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.27.40677-bionic_amd64.deb
	sudo dpkg -i *.deb
	which nautilus && sudo apt install insync-nautilus -y
	which nemo && sudo apt install insync-nemo -y
}

declare -f INSTLIBREOFFICE
function INSTLIBREOFFICE()
{
	sudo add-apt-repository ppa:libreoffice/ppa -y
	sudo apt update && sudo apt dist-upgrade -y
	which libreoffice || sudo apt install libreoffice libreoffice-l10n-br -y
}

#--- Desinstalar Programas ---#
declare -f RMSOFTWARES
function RMSOFTWARES()
{
 	for CHOICE in $selection; do
 		echo "#========== Removendo $CHOICE ==========#"
		sleep 2
 		sudo apt remove $CHOICE -y
 	done
 	VERIFY_DISTRIB
}

######========== LinuxMint ==========######

###### Função Menu Principal ######
declare -f MENU_MINT
function MENU_MINT()
{
	selection=$(zenity --list --title='Selection' --column="#" --column="Softwares" \
	FALSE "Atualizar Repositórios e Sistema" \
	FALSE "Instalar Programas" \
	FALSE "Desinstalar Programas Embutidos" \
	--radiolist  --height=200 --width=300 )
	
	if [[ -z $selection  ]]; then
		exit 0
	fi
	case "$selection" in
	    "Atualizar Repositórios e Sistema" )
	    	UPDATE
	    	;;  	
	    "Instalar Programas" )
	    	INSTMENU_MINT
	    	;;
	   	"Desinstalar Programas Embutidos" )
			RMMENU_MINT
			;;
	    * )
	        echo "Opção inválida, tente novamente!"
	        ;;
	esac
	exit 0
}

declare -f INSTMENU_MINT
function INSTMENU_MINT()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "Google-Chrome-Stable" "Web browser" \
	FALSE "Tor-Browser-Launcher-FlatHub" "Private Web Browser" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
	FALSE "Discord-FlatHub" "Voice Messenger" \
	FALSE "Jdownloader-FlatHub" "Downloader Manager" \
	FALSE "whatsapp-desktop" "Messenger" \
 	FALSE "Sublime-Text-FlatHub" "IDE for development" \
	FALSE "ubuntu-restricted-extras" "Additional (codec, flash and etc...)" \
	FALSE "mpv" "Video Player" \
	FALSE "celluloid" "Video Player" \
	FALSE "audacious" "Audio Player" \
	FALSE "gnome-calendar" "Calendar" \
	FALSE "gnome-maps" "Maps" \
	FALSE "gnome-contacts" "Contacts" \
	FALSE "gnome-weather" "Weather" \
	FALSE "shutter" "PrintScreen Tool" \
	FALSE "flameshot" "PrintScreen Tool" \
	FALSE "snapd" "core for SNAP containers" \
	FALSE "kdenlive" "Video editor" \
	FALSE "ffmpeg" "Back-End Tool for Media Conversion" \
	FALSE "winff" "Front-End for FFMPEG"\
	FALSE "mint-meta-codecs" "Codec Pack" \
	FALSE "synaptic" "Package Manager" \
	FALSE "gparted" "Partition Manager" \
	FALSE "geary" "EMAIL CLIENT" \
	FALSE "clipit" "Clipboard Manager" \
	FALSE "virtualbox-qt" "Virtualization" \
	FALSE "wine-stable" "Layer for Windows Software" \
	FALSE "libreoffice" "Office Tools" \
	FALSE "WPS-Office-FlatHub" "Office Tools" \
	FALSE "ONLYOFFICE-FlatHub" "Office Tools" \
	FALSE "Handbrake-FlatHub" "Video conversion tools" \
	FALSE "transmission" "Torrent client" \
	FALSE "keepassxc" "Password Manager" \
	FALSE "Unpackers" "zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress" \
	FALSE "steam-installer" "Game Store" \
	FALSE "zsnes" "SuperNes emulator" \
	FALSE "ttf-mscorefonts-installer" "Microsoft fonts" \
	--separator=" "	--checklist  --height=650 --width=650 )
	
	if [[ -z $selection  ]]; then
		MENU_MINT
	fi
	INSTSOFTWARE
}

declare -f RMMENU_MINT
function RMMENU_MINT()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "hexchat" "Chat" \
	FALSE "firefox" "Web browser" \
	FALSE "thunderbird" "EMAIL CLIENT" \
	FALSE "rhythmbox" "Audio Player" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU_MINT
	fi
	RMSOFTWARES
}

######========== Ubuntu ==========######
###### Main Menu Function ######
declare -f MENU_UBUNTU
function MENU_UBUNTU()
{
	selection=$(zenity --list --title='Selection' --column="#" --column="Softwares" \
	FALSE "Atualizar Repositórios e Sistema" \
	FALSE "Instalar Programas" \
	FALSE "Desinstalar Programas Embutidos" \
	--radiolist  --height=200 --width=300 )
	
	if [[ -z $selection  ]]; then
		exit 0
	fi
	case "$selection" in
	    "Atualizar Repositórios e Sistema" )
	    	UPDATE
	    	;;  	
	    "Instalar Programas" )
	    	INSTMENU_UBUNTU
	    	;;
	   	"Desinstalar Programas Embutidos" )
			RMMENU_UBUNTU
			;;
	    * )
	        echo "Opção inválida, tente novamente!"
	        ;;
	esac
	exit 0
}

declare -f INSTMENU_UBUNTU
function INSTMENU_UBUNTU()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "Google-Chrome-Stable" "Web browser" \
	FALSE "Tor-Browser-Launcher-FlatHub" "Private Web Browser" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
	FALSE "Discord-FlatHub" "Voice Messenger" \
	FALSE "Jdownloader-FlatHub" "Downloader Manager" \
	FALSE "Whatsapp-desktop-Snap" "Messenger" \
	FALSE "Sublime-Text-FlatHub" "IDE for development" \
	FALSE "ubuntu-restricted-extras" "Additional (codec, flash and etc...)" \
	FALSE "mpv" "Video Player" \
	FALSE "celluloid" "Video Player" \
	FALSE "audacious" "Audio Player" \
	FALSE "Vlc" "Audio Player" \
	FALSE "gnome-calendar" "Calendar" \
	FALSE "gnome-maps" "Maps" \
	FALSE "gnome-contacts" "Contacts" \
	FALSE "gnome-weather" "Weather" \
	FALSE "shutter" "PrintScreen Tool" \
	FALSE "flameshot" "PrintScreen Tool" \
	FALSE "kdenlive" "Video editor" \
	FALSE "ffmpeg" "Back-End Tool for Media Conversion" \
	FALSE "winff" "Front-End for FFMPEG"\
	FALSE "synaptic" "Package Manager" \
	FALSE "gparted" "Partition Manager" \
	FALSE "geary" "EMAIL CLIENT" \
	FALSE "virtualbox-qt" "Virtualization" \
	FALSE "wine-stable" "Layer for Windows Software" \
	FALSE "libreoffice" "Office Tools" \
	FALSE "WPS-Office-FlatHub" "Office Tools" \
	FALSE "ONLYOFFICE-FlatHub" "Office Tools" \
	FALSE "Handbrake-FlatHub" "Video conversion tools" \
	FALSE "transmission" "Torrent client" \
	FALSE "keepassxc" "Password Manager" \
	FALSE "Unpackers" "zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress" \
	FALSE "steam-installer" "Game Store" \
	FALSE "zsnes" "SuperNes emulator" \
	FALSE "ttf-mscorefonts-installer" "Microsoft fonts" \
	FALSE "gnome-tweaks" "Gnome extra settings" \
	--separator=" "	--checklist  --height=650 --width=650 )
	
	if [[ -z $selection  ]]; then
		MENU_UBUNTU
	fi
	which flatpak || sudo apt install flatpak gnome-software-plugin-flatpak -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list && sudo apt update	
	INSTSOFTWARE
}

declare -f RMMENU_UBUNTU
function RMMENU_UBUNTU()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "firefox" "Web browser" \
	FALSE "thunderbird" "EMAIL CLIENT" \
	FALSE "rhythmbox" "Audio Player" \
	FALSE "remmina" "remote connection" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU_UBUNTU
	fi
	RMSOFTWARES
}

#========== EXECUTION ==========#
VERIFY_ROOT
VERIFY_DISTRIB
