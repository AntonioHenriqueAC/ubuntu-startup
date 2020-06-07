sudo apt-get update -y

eval echo ~$USER

echo 'installing curl' 
sudo apt install curl -y

echo 'installing git' 
sudo apt install git -y

echo 'Installing vim'
sudo apt install vim -y
clear

echo "Can I set VIM as your default GIT editor for you? (y/n)"
read git_core_editor_to_vim
if echo "$git_core_editor_to_vim" | grep -iq "^y" ;then
	git config --global core.editor vim
else
	echo "Okay, no problem. :) Let's move on!"
fi

echo "What name do you want to use in GIT user.name?"
echo "For example, mine will be \"Antonio Cardoso\""
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear 

echo "What email do you want to use in GIT user.email?"
echo "For example, mine will be \"antoniohenriqueac@gmail.com\""
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo 'Installing tool to handle clipboard via CLI'
sudo apt-get install xclip -y

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
eval `ssh-agent -s`
ssh-add
clip.exe < ~/.ssh/id_rsa.pub
echo "Paste your SSH key in your Github (github.com/settings/keys) -> (ctrl + v) !!"

echo 'Installing zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

mv .zshrcNew $HOME/.zshrc

echo 'installing autosuggestions, zsh-completions and zsh-syntax-highlighting' 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
git clone git://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
echo "source ~/.zsh/zsh-completions/zsh-completions.zsh" >> ~/.zshrc
source ~/.zshrc

echo 'installing theme'
sudo apt install fonts-firacode -y
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Installing Visual Studio Code'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

echo 'Installing extensions'
code --install-extension alexandersage.angular1-code-snippets
code --install-extension formulahendry.auto-rename-tag
code --install-extension hookyqr.beautify
code --install-extension coenraads.bracket-pair-colorizer
code --install-extension ms-vscode.cpptools
code --install-extension vikas.code-navigation
code --install-extension formulahendry.code-runner
code --install-extension naumovs.color-highlight
code --install-extension luis.console-log
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension redhat.fabric8-analytics
code --install-extension ms-azuretools.vscode-docker
code --install-extension mikestead.dotenv
code --install-extension geeebe.duplicate
code --install-extension dhide.easy-php-error-logger
code --install-extension editorconfig.editorconfig
code --install-extension digitalbrainstem.javascript-ejs-support
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension dbaeumer.vscode-eslint
code --install-extension waderyan.gitblame
code --install-extension donjayamanne.githistory
code --install-extension eamodio.gitlens
code --install-extension spywhere.guides
code --install-extension ecmel.vscode-html-css
code --install-extension wix.vscode-import-cost
code --install-extension zignd.html-css-class-completion
code --install-extension nickdemayo.vscode-json-editor
code --install-extension ritwickdey.live-sass
code --install-extension ritwickdey.liveserver
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension yzhang.markdown-all-in-one
code --install-extension monokai.theme-monokai-pro-vscode
code --install-extension afractal.node-essentials
code --install-extension eg2.vscode-npm-script
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension felixfbecker.php-intellisense
code --install-extension alefragnani.project-manager
code --install-extension ms-python.python
code --install-extension tht13.python
code --install-extension esbenp.prettier-vscode
code --install-extension wallabyjs.quokka-vscode
code --install-extension ms-vscode.references-view
code --install-extension jasonnutter.search-node-modules
code --install-extension shan.code-settings-sync
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension funkyremi.vscode-google-translate
code --install-extension vscode-icons-team.vscode-icons
code --install-extension shyykoserhiy.vscode-spotify
code --install-extension dotjoshjohnson.xml
code --install-extension redhat.vscode-yaml

echo 'Installing spotify' 
snap install spotify

echo 'installing chrome' 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo 'installing nvm' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
nvm --version
nvm install 12
nvm alias default 12
node --version
npm --version

echo 'installing slack' 
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.8-amd64.deb
sudo apt install ./slack-desktop-*.deb -y

echo 'installing docker' 
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

chmod 777 /var/run/docker.sock
docker run hello-world

echo 'installing docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo 'installing aws-cli' 
sudo apt-get install awscli -y
aws --version
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
session-manager-plugin --version

echo 'installing teamviewer'
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install -y ./teamviewer_amd64.deb

echo 'installing vnc-viewer'
sudo apt-get install -y --no-install-recommends ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
sudo apt-get install vnc4server -y 