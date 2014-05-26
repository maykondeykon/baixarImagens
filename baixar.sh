#!/bin/bash
######################################################
## baixar.sh - Baixa imagens sequenciais de sites   ##
## Escrito por: Maykon Deykon)                      ##
## E-mail: maykondeykon@gmail.com                   ##
## OpenSuse GNU/Linux 13.1                          ##
######################################################

# URL da página
url="http://www.empireonline.com/images/image_index/original"
# nome da primeira imagem
init=65628
# Quantidade de imagen a baixar
qt=2
# extensão do arquivo
ext="jpg"
# renomear o arquivo (sem espaços)
name="star_wars" 

max=$(($init + $qt -1))
j=1
for i in `seq $init $max`
do
	wget -c $url/$i.$ext

	if [ ! -z $name ]; then
		mv $i.$ext $name"-"$j.$ext
		j=$(( $j + 1 ))
	fi
	
done

