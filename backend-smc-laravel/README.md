<p align="center">
	<img src="https://github.com/emaworkdev/projeto-smc/blob/master/resources/laravel.png" alt="dart-logo" width="100" />		
        <p align="center">Projeto SMC - Servidor Laravel</p>
</p>

<hr>

## Servidor Laravel
micro serviço de disparos

# Instalação

<p align="left">Considerando que você já Clonou o repositorio para o seu servidor.</p>

```bash
sudo apt update
  
# *** PHP ****
sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update
sudo apt install php7.2-fpm php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-zip

sudo apt install php7.2-intl
sudo apt install php7.2-curl
sudo apt install php7.2-mysql

sudo vim /etc/php/7.2/fpm/php.ini

# buscar palavra pelo vim  digitar / ou ?

# alterar isso

memory_limit = 256M
upload_max_filesize = 64M
cgi.fix_pathinfo=0

# Instalar o Composer

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# MUDAR COMPOSER PARA VERSAO 2
composer self-update

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/


cp -R ./projeto-smc/backend-smc-laravel /var/www/html/api-smc-laravel

cd /var/www/html/api-smc-laravel 

sudo chmod 777 -R storage
sudo chmod 777 -R storage/*
sudo chmod 777 -R app


composer update

cp .env.example .env

php artisan key:generate

vim .env

# modo de insert: pressionar a tecla shift+i
# alterar 

# <seu dominio> = substituir pelo seu dominio do hassura
# senha = senha do hasura

API_HASURA=http://<seu dominio>/v1/graphql
API_HASURA_CREDENCY="senha"

# ip =  maquina onde esta o wppconnect-server
# porta = porta configurada no arquivo confing.json o wppconnect
# substituir ip e porta a baixo 

API_WPP=http://ip:porta/api

# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER


php artisan config:clear && php artisan config:cache && php artisan cache:clear && php artisan route:clear && composer dump-autoload

php artisan config:cache && php artisan config:clear

php artisan

vim /var/www/html/api-smc-laravel/app/Console/Kernel.php


sudo crontab -e

# modo de insert: pressionar a tecla shift+i

* * * * * cd /var/www/html/api-smc-laravel/ && php artisan schedule:run >> /dev/null 2>&1

# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER
 
```


