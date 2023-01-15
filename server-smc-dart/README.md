<p align="center">
	<img src="https://github.com/emaworkdev/projeto-smc/blob/master/resources/dart.png" alt="dart-logo" width="100" />		
        <p align="center">Projeto SMC - Servidor Dart</p>
</p>

<hr>

## Servidor Dart

# Instalação

<p align="left">Considerando que você já Clonou o repositorio para o seu servidor.</p>

```bash
sudo apt update

# link https://dart.dev/get-dart

sudo apt-get update
sudo apt-get install apt-transport-https
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
 
sudo apt-get update
sudo apt-get install dart

export PATH="$PATH:/usr/lib/dart/bin"
echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

dart --version

cd projeto-smc/server-smc-dart

# na pasta raiz do projeto
# baixar as dependências

dart pub get

cp .env.example .env

vim .env

# modo de insert: pressionar a tecla shift+i
# alterar 

port=8081

secretKey = "secret" # secret key do arquivo config.json do wpp-connect-serve
wppConnectHost="http://ip:porta/api" >>>> ip e porta da maquina onde está instalado o wppcconnet-server
urlWebhookAlvo="http://<seu dominio server-dart>/webhooks/"
urlWebhookClient="http://<seu dominio server-dart>/webhooks/secunds"                

hasuraHost="http://<seu dominio hasura>/v1/graphql"
hasuraPassword="senha hasura"

urlFrontEnd="<url do front-end> ou * para local"


# para sair do modo insert
# pressionar a tecla ESC
# entrada de comando
# pressionar a tecla :
# para salvar e sair
# digitar wq + ENTER


dart bin/server.dart

# vai printar na tela htt://localhost:8081

# ctrl + C parar o teste

# retrocede um diretorio
cd ..

# lista diretorio projeto-smc
ls

# vai encontrar um arquivo api_smc.sh
# para subir o serviço server-smc-dart

sh api_smc.sh

# será criado um arquivo de log do serviço.

# para ver oss serviços dart
ps aux | grep dart

# para terminar um serviço
kill -9 <nro pid>

sudo vim /etc/nginx/sites-available/<nome do servico>

# modo de insert: pressionar a tecla shift+i
# copiar esse scrypt abaixo 
# exemplo.com trocar pelo dominio do server-smc-dart
# <porta> troccar pela porta do serviço server-smc-dart configurado no arquivo .env

server {
  listen 80;
 
  root /var/www/html;	

  server_name example.com;

  location / {
    proxy_pass http://localhost:<porta>;
    proxy_http_version 1.1;           
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

sudo certbot --nginx -d <dominio do server-smc-dart>

sudo service nginx reload


```
