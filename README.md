<p align="center">
	<img src="https://raw.githubusercontent.com/emaworkdev/projeto-smc/master/resources/smc.png" alt="smc-logo" width="100" />		
        <p align="center">Projeto SMC - Sistema de Maturação de Chips</p>
</p>

SMC é um programa que sincroniza dois perfis de Whatsapp e conversa automaticamente (com conversas pré-gravadas) entre eles,
cria status no chip, para deixar o mais real possível e aquece os seus números de chips do whatsapp para que possam ser usados em campanhas de marketing, quem envia muitos disparos pelo whatsapp sabe que está sujeito a bloqueios e isso acontece muito mais fácil se o numero não for maturado.

<hr>
<p align="left">
	<img src="https://telegram.org/favicon.ico" alt="Telegram-logo" width="32" />
	<span>Telegram: </span>
	<a href="https://t.me/emawork_smc" target="_blank">Grupo</a>
	<span> || </span>
	<a href="https://t.me/emawork_smc" target="_blank">Canal</a>
</p>

<hr>
# Apresentação do SMC video

  [![Demo Doccou alpha](https://bucket-emawork.nyc3.digitaloceanspaces.com/emawork_com/banners/youtube_video.png)](https://www.youtube.com/watch?v=t81rsBqK6iM)
  
# SMC Instalação video

  [![Demo Doccou alpha](https://bucket-emawork.nyc3.digitaloceanspaces.com/emawork_com/banners/youtube_video.png)](https://www.youtube.com/watch?v=mSNIRT6-WQ0&t=90s)

<hr>

### Clone o projeto

```bash

git clone https://github.com/emaworkdev/projeto-smc.git

# Acertar data e fuzo horario se necessario

sudo apt update

# Configurando o Locale pt_BR no Ubuntu
# As máquinas Ubuntu AMI não vêm com o Locale pt_BR configurado por padrão, 
# mas é muito fácil configurar o mesmo:

sudo locale-gen pt_BR
sudo locale-gen pt_BR.UTF-8
sudo dpkg-reconfigure locales

# Alterar o fuso horário no Ubuntu/Debian pelo terminal
# Alterando o fuso horário no Debian
# Primeiro, verifique a data e hora local, para isso use o comando:

date
# Será apresentado algo como:

# Tue Mar 20 08:36:26 -03 2018
# Agora para alterar o fuso horário digite:

sudo dpkg-reconfigure tzdata

# Serão mostradas as respectivas telas para selecionar a região e o fuso horário:
# Para navegar entre as opções utilize a seta ou o mouse.
# Após selecionar o correto, clique em < OK >.

# Em seguida será apresentado o log.

# Current default time zone: 'America/Sao_Paulo'
# Local time is now:      Tue Mar 20 08:21:57 -03 2018.
# Universal Time is now:  Tue Mar 20 11:21:57 UTC 2018.
# Verificando a data e o TimeZone
# Para verificar a nova data, utilize os comandos:

# date
# Tue Mar 20 08:36:26 -03 2018
# date -u
# Tue Mar 20 11:36:30 UTC 2018
# Note que o -u faz o sistema mostrar a data sem o TimeZone aplicado.

# REINICIAR MAQUINA

```

<hr>

<details>
  <summary>Importante: criar os domínios</summary>
	
  |      TIPO             | NOME              |   DADOS          | TTL       |
  | --------------------- |:-----------------:|:----------------:|:---------:|
  |        A              | smc               | SEU IP SERVIDOR  | PADRÃO    | - FRONTEND
  |        A              | server-smc        | SEU IP SERVIDOR  | PADRÃO    | - SERVIDOR SERVER-SMC-DART
  |        A              | hasura            | SEU IP SERVIDOR  | PADRÃO    | - HASURA
	
  ### Exemplo: importante substitua exemplo.com pelo seu domínio	
  	
  ```bash
  
	sms.exemplo.com           -> frontend
	server-sms.exemplo.com    -> backend: server-smc-dart
	hasura.exemplo.com        -> hasura (banco de dados)
     
```	
	
</details>

<details>
  <summary>1) - Instalando Hasura & Postgres</summary>
  <p align="left">
       <span>github: <a target="_blank" href="https://github.com/emaworkdev/hasura">docker-hasura</a>.</span>
  </p>
 
  ## Video - Criando um servidor hasura + postgree com docker

  [![Demo Doccou alpha](https://bucket-emawork.nyc3.digitaloceanspaces.com/emawork_com/banners/youtube_video.png)](https://www.youtube.com/watch?v=VZ4pYxN88vg&t=141s)
	
<p align="left">
       <span>Opção com caprover <a>veja video</a>.</span>
  </p>
 
  ## Video - Criando um servidor com CapRover e implantando o Hasura

  [![Demo Doccou alpha](https://bucket-emawork.nyc3.digitaloceanspaces.com/emawork_com/banners/youtube_video.png)](https://www.youtube.com/watch?v=mSNIRT6-WQ0&t=90s)	
	
</details>

<details>
  <summary>2) - Instalando WPPConnectServer</summary>
  <p align="left">
     <span>siga os procedimentos de instalação do <a target="_blank" href="https://github.com/wppconnect-team/wppconnect-server">wppcconnect-server</a>.     </span>
  </p>
  
   ```bash
	
git clone https://github.com/wppconnect-team/wppconnect-server.git
	
# Instalando Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update

# Instalar yarn
sudo apt install yarn

# Instalar o Node
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v
	
	
sudo apt-get install -y libxshmfence-dev libgbm-dev wget unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
	
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt-get update

sudo dpkg -i google-chrome-stable_current_amd64.deb
	
# Instalar o pm2

sudo npm install pm2@latest -g
pm2 startup systemd
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u root --hp /home/root

# Configurar arquivo config.json
	
vim /root/wppconnect-server/src/config.json
	
# modo de insert: pressionar a tecla shift+i
 	

{
  "secretKey": "THISISMYSECURETOKEN",    >>> colocar a sua secretKey
  "host": "http://localhost",
  "port": "21465",
  "deviceName": "WppConnect",
  "poweredBy": "WPPConnect-Server",
  "startAllSession": true,
  "tokenStoreType": "file",
  "maxListeners": 15,
  "customUserDataDir": "./userDataDir/",
  "webhook": {
    "url": null,       >>>> https:// <colocar o dominio server-dart> /api/webhooks
    "autoDownload": true,
    "uploadS3": false,
    "readMessage": true,
    "allUnreadOnStart": false,
    "listenAcks": true,
    "onPresenceChanged": true,
    "onParticipantsChanged": true,
    "onReactionMessage": true,
    "onPollResponse": true,
    "onRevokedMessage": true
  },
  "archive": {
    "enable": false,
    "waitTime": 10,
    "daysToArchive": 45
  },
  "log": {
    "level": "error",
    "logger": ["console", "file"]
  },
  "createOptions": {
    "browserArgs": [
      "--disable-web-security",
      "--no-sandbox",
      "--disable-web-security",
      "--aggressive-cache-discard",
      "--disable-cache",
      "--disable-application-cache",
      "--disable-offline-load-stale-cache",
      "--disk-cache-size=0",
      "--disable-background-networking",
      "--disable-default-apps",
      "--disable-extensions",
      "--disable-sync",
      "--disable-translate",
      "--hide-scrollbars",
      "--metrics-recording-only",
      "--mute-audio",
      "--no-first-run",
      "--safebrowsing-disable-auto-update",
      "--ignore-certificate-errors",
      "--ignore-ssl-errors",
      "--ignore-certificate-errors-spki-list"
    ]
  },
  "mapper": {
    "enable": false,
    "prefix": "tagone-"
  },
  "db": {
    "mongodbDatabase": "tokens",
    "mongodbCollection": "",
    "mongodbUser": "",
    "mongodbPassword": "",
    "mongodbHost": "",
    "mongoIsRemote": true,
    "mongoURLRemote": "",
    "mongodbPort": 27017,
    "redisHost": "localhost",
    "redisPort": 6379,
    "redisPassword": "",
    "redisDb": 0,
    "redisPrefix": "docker"
  }
}
	
# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER	
	
# LIBERAR PORTA DO WPPCONNECT
sudo iptables -A INPUT -p tcp --dport 21465 -j ACCEPT

MOSTRAR PORTAS
sudo netstat -t -l -p --numeric-ports
	
cd wppconnect-server
	
yarn install

yarn build

pm2 start dist/server.js --name wppconnect
pm2 save	

pm2 list
pm2 logs 0	
	
   ```   	
	
</details>

<details>
  <summary>3) - Instalando o servidor Dart</summary>
  <p align="left">
       <span>github: <a target="_blank" href="https://github.com/emaworkdev/projeto-smc/tree/master/server-smc-dart">server-smc-dart</a>.</span>
  </p>
</details>

<details>
  <summary>4) - Instalando o servidor Laravel</summary>
  <p align="left">
       <span>github: <a target="_blank" href="https://github.com/emaworkdev/projeto-smc/tree/master/backend-smc-laravel">server-smc-laravel</a>.</span>
  </p>
</details>

<details>
  <summary>5) - Instalando o fronten Flutter</summary>	
  <p align="left">
       <span>github: <a target="_blank" href="https://github.com/emaworkdev/projeto-smc/tree/master/frontend-smc">frontend-scm</a>.</span>
  </p>

</details>

<details>
  <summary>Finalizando</summary>
	
  ```bash	
	# Após tudo instalado digitar no navegador 
	https://<dominio smc front-en>

	# apagar pastas não mais necessaria no servidor

	sudo rm -R projeto-smc/backend-smc-laravel
	sudo rm -R projeto-smc/frontend-smc

	# Não apagar a pasta resources inteira pois nela tem 2 arquivos ainda necessario
	  - db.txt
	  - conversas.txt

	sudo rm -R projeto-smc/resources/dart.png
	sudo rm -R projeto-smc/resources/laravel.png
	sudo rm -R projeto-smc/resources/flutter.png
	sudo rm -R projeto-smc/resources/smc.png
	sudo rm -R projeto-smc/resources/tela1.png
	sudo rm -R projeto-smc/resources/tela2.png
	sudo rm -R projeto-smc/resources/tela3.png
	sudo rm -R projeto-smc/resources/tela4.png
	sudo rm -R projeto-smc/resources/donate.png

	sudo rm projeto-sm/README.md
  ```
	
</details>

<hr>

<a href="https://www.digitalocean.com/?refcode=10cf6e2be6d4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge"><img src="https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%202.svg" alt="DigitalOcean Referral Badge" /></a>

<hr>
	
## FIQUE ATENTO

Este projeto não é afiliado, associado, autorizado, endossado por, ou de qualquer forma oficialmente ligado à WhatsApp, ou a qualquer uma das suas filiais ou afiliadas. O website oficial da WhatsApp pode ser encontrado em <https://whatsapp.com>. "WhatsApp", bem como nomes, marcas, emblemas e imagens relacionadas são marcas registadas dos seus respectivos proprietários.

--------------------------

### Curtiu? Pague-me um café!! Segue QR code (PIX)  

[<img src="/resources/donate.png" height="150" width="200"/>](/resources/donate.png)
	
<hr>	
	
### License

[![License GNU AGPL v3.0](https://img.shields.io/badge/License-AGPL%203.0-lightgrey.svg)](https://github.com/sufficit/sufficit-quepasa-fork/blob/master/LICENSE.md)

