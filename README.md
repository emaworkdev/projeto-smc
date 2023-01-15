<p align="center">
	<img src="https://raw.githubusercontent.com/emaworkdev/projeto-smc/master/resources/smc.png" alt="smc-logo" width="100" />		
        <p align="center">Projeto SMC - Sistema de Maturação de Chips</p>
</p>

SMC é um programa que sincroniza dois perfis de Whatsapp e conversa automaticamente (com conversas pré-gravadas) entre eles,
cria status no chip, para deixar o mais real possível e aquece os seus números de chips do whatsapp para que possam ser usados em campanhas de marketing, quem envia muitos disparos pelo whatsapp sabe que está sujeito a bloqueios e isso acontece muito mais fácil se o numero não for maturado.

<hr>
# Apresentação do SMC video

  [![Demo Doccou alpha](https://bucket-emawork.nyc3.digitaloceanspaces.com/emawork_com/banners/youtube_video.png)](https://www.youtube.com/watch?v=t81rsBqK6iM)
  
<hr>

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
     <span>siga os procedimentos de instalação do <a target="_blank" href="https://github.com/wppconnect-team/wppconnect-server">wppcconnect-server</a>.</span>
  </p>
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

	sudo rm projeto-sm/README.md
  ```
	
</details>

<hr>

<a href="https://www.digitalocean.com/?refcode=10cf6e2be6d4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge"><img src="https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%202.svg" alt="DigitalOcean Referral Badge" /></a>

<hr>
	
### License

[![License GNU AGPL v3.0](https://img.shields.io/badge/License-AGPL%203.0-lightgrey.svg)](https://github.com/sufficit/sufficit-quepasa-fork/blob/master/LICENSE.md)

