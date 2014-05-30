#!/bin/bash
#########################################################
## baixar2.sh - Automatiza o download de imagens       ##
## Versão que carrega uma lista de arquivos pra baixar ##
## Data: 30/05/2014                                    ##
## Escrito por: Maykon Deykon                          ##
## E-mail: maykondeykon@gmail.com                      ##
## OpenSuse GNU/Linux 13.1                             ##
#########################################################

# Indica o arquivo que contem as url's das imagens
lista=$HOME/Dropbox/Documentos/lista.txt
# Indica pasta destino dos arquivos
destino=$HOME/Downloads/.tempx

# Cria a pasta se ela não existir
mkdir -p $destino
# Executa o download
wget -r -c -P $destino -i $lista

