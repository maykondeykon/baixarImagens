#!/bin/bash
######################################################
## baixar.sh - Baixa imagens sequenciais de sites   ##
## Data: 26/05/2014                                 ##
## Escrito por: Maykon Deykon                       ##
## E-mail: maykondeykon@gmail.com                   ##
## OpenSuse GNU/Linux 13.1                          ##
######################################################

# URL da página
url=""
# http://www.empireonline.com/images/image_index/original/65629.jpg
# nome da primeira imagem
init=""
# Quantidade de imagen a baixar
qt=""
# extensão do arquivo
ext=""
# renomear o arquivo (sem espaços)
name=""
temp=.temp
destino=$HOME/Downloads
# destino="$HOME"



Principal(){
	
	GetUrl	
	# Teste
}

Teste(){
	echo -n "Informe a pasta de destino: "
	read dir
	if [  -d $HOME/$dir ]
		then
		clear
		SetName
	else
		echo $HOME/$dir' nao existe, deseja cria-la? [s,n]'
		read cria
		if [  $cria = 's' ]
			then
			echo "criando pasta..."
			destino=$HOME/$dir
			mkdir -p $destino
			sleep 1
			clear
			SetName
		else
			clear
			Teste
			
		fi
	fi
}

GetUrl(){
	echo -n "Informe a URL do site: "
	read url
	if [  ! -z $url ]
		then

		if curl --output /dev/null --silent --head --fail "$url"
			then
			GetNome
		else
			echo 'Informe uma URL valida!'
			sleep 2
			clear
			GetUrl
		fi

	else
		echo 'Informe uma URL valida!'
		sleep 2
		clear
		GetUrl
	fi
}
GetNome(){
	echo -n "Informe o nome da primeira imagem: "
	read init
	if [  ! -z $init ]
		then
		ext="${init#*.}"
		init="${init%%.*}"
		GetQtd
	else
		echo 'Informe um nome valido!'
		sleep 2
		clear
		GetNome
	fi
}
GetQtd(){
	echo -n "Quantas imagens devem ser baixadas? "
	read qt
	if [  ! -z $qt ]
		then
		setDiretorio
	else
		echo 'Informe a quantidade!'
		sleep 2
		clear
		GetQtd
	fi
}
SetName(){
	echo -n "Informe aqui o novo nome do arquivo, ou deixe em branco: "
	read name
	Download
}
setDiretorio(){
	echo -n "Informe a pasta de destino: "
	read dir
	if [  -d $HOME/$dir ]
		then
		clear
		SetName
	else
		echo $HOME/$dir' nao existe, deseja cria-la? [s,n]'
		read cria
		if [  $cria = 's' ]
			then
			echo "criando pasta..."
			destino=$HOME/$dir
			mkdir -p $destino
			sleep 1
			clear
			SetName
		else
			clear
			Teste
			
		fi
	fi
}

Download(){
	mkdir -p $temp
	max=$(($init + $qt -1))
	j=1
	for i in `seq $init $max`
	do
		wget -q --spider $url/$i.$ext

		if [  $? = 0 ]
			then
			wget -c -P .temp $url/$i.$ext

			if [  ! -z $name ]
				then
				mv $temp/$i.$ext $destino/$name"-"$j.$ext
				j=$(( $j + 1 ))
			else
				mv $temp/$i.$ext $destino/
			fi

		else
			echo 'Arquivo Nao encontrado!'
		fi
		
	done
	rm -Rf $temp
}

Principal

sleep 10
