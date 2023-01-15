<p align="center">
	<img src="https://github.com/emaworkdev/projeto-smc/blob/master/resources/flutter.png" alt="flutter-logo" width="100" />		
        <p align="center">Projeto SMC - Front-End Flutter</p>
</p>

<hr>

## Flutter v 3.3.9

# Instalação

<p align="left">Considerando que você já Clonou o repositorio para o seu servidor.</p>

```bash

cp -R ./projeto-smc/frontend-smc/build/web  /var/www/html/app/web/

cd /var/www/html/app/web/assets/assets/dir

cp .env.example .env

vim .env

# modo de insert: pressionar a tecla shift+i

endpointApi=<seu dominio smc> # dominio do frontend

# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER

sudo vim /etc/nginx/sites-available/<nome do servico>

# dentro do editor vim para entrar no modo de insert: pressionar a tecla shift+i

# colar esse scrypt abaixo 

server {
  root /var/www/html/app/web;
  index index.php index.html index.htm;
  server_name <seu dominio smc front-end>;
  
  location / {
    try_files $uri $uri/ /index.php?$query_string;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
   fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
   fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
  }

}

# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER

sudo service nginx restart && sudo service nginx reload && sudo nginx -t

sudo ln -s /etc/nginx/sites-available/<nome servico> /etc/nginx/sites-enabled/

sudo systemctl restart nginx.service

sudo certbot --nginx -d <dominio do smc front-end>

sudo service nginx reload

```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
