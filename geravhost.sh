#Criado por Adler Parnas <adler.parnas@doisdeum.com.br>   #
#                                                         #
# 2011-02-23                                              #
#                                                         #
# Adaptado por Lauro Guedes <leowgweb.com>                #
#                                                         #
# 2015-11-26                                              #
###########################################################
#                                                         #
# Script para criar um virtual host no apache e adicionar #
# o nome do host no arquivo hosts                         #
#                                                         #
###########################################################
#!/bin/bash
 
echo "Informe o nome do servidor (Ex.: siteexemplo) :"
read vhost
 
echo "Informe o caminho do site (Ex.: /Users/fhferreira/jobs/projeto-1/public) :"
read path

echo "Criando configuração de VHost para o servidor"

#aqui é criado o arquivo de virtual host para o domínio e 
#é feita a escrita das configurações no arquivo
echo "<VirtualHost *:80>
    	ServerAdmin webmaster@localhost
    	ServerName $vhost
    	ServerAlias www.$vhost 
    	DocumentRoot /Users/fhferreira/jobs/$path
   	 <Directory /Users/fhferreira/jobs/$path>
       		Options Indexes FollowSymLinks MultiViews
        	AllowOverride All
        	Order allow,deny
        	Allow from all
    	 </Directory>
</VirtualHost>" > /usr/local/etc/apache2/2.4/sites/$vhost.conf

#ativa-se o o virtual host para que o serviço possa reconhecê-lo
#echo "Ativando VHOST $vhost"
#a2ensite $vhost.conf

#escreve no arquivo de hosts do linux
echo "Atualizando arquivo hosts"
echo "127.0.1.1     $vhost www.$vhost" >> /etc/hosts

#renicia-se o servidor apache para aplicar as configurações
echo "Reiniciando apache";
sudo apachectl -k restart
 
echo "VHOST criado";
