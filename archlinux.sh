echo export PATH="${PATH}:$HOME/.local/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile


sudo pacman -Syu git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
sudo pacman -Syu nano vim git htop networkmanager wpa-supplicant dialog dosfstools\
    ntfs-3g base-devel linux-headers openssh aria2 curl wget htop neofetch cowsay zsh gcc clang tmux
sudo yay -S tty-clock-git

echo -n "Install KDE (y/N)?"
while :
do
    read INPUT
    case $INPUT in
        y)
            sudo pacman -Syu sddm plasma sddm-kcm dolphin konsole krfb code firefox network-manager-applet\
                mesa lib32-mesa  mesa-utils
            #pacman -Syu krdp #(kde-unstable)
            break
            ;;
        n|N)
            break
  esac
done

echo -n "Install extra fonts and IMEs (y/N)?"
while :
do
    read INPUT
    case $INPUT in
        y)
            sudo pacman -Syu ttf-cascadia-code otf-cascadia-code noto-fonts noto-fonts-cjk ttf-cascadia-code \
                ttf-arphic-ukai adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts\
                fcitx5 fcitx5-configtool fcitx5-mozc fcitx5-chinese-addons
            break
            ;;
        n|N)
            break
  esac
done

echo -n "Install oh-my-zsh (y/N)?"
while :
do
    read INPUT
    case $INPUT in
        y)
            sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

            echo "Configure it manually!"
            break
            ;;
        n|N)
            break
  esac
done

