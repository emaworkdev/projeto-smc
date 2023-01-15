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

cd projeto-smc/erver-smc-dart

# na pasta raiz do projeto
# baixar as dependências

dart pub get

cp .env.example .env




dart bin/server.dart

```
