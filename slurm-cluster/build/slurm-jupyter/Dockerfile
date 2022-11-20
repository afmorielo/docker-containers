#Base Ubuntu 20.04 LTS
FROM ubuntu:20.04

#Desabilite qualquer possiblidade de interação durante a instalação
ARG DEBIAN_FRONTEND=noninteractive

#Pacotes não relacionados ao Slurm
RUN apt update -y && \
apt install nano -y && \
apt install build-essential -y && \
apt install git -y && \
apt install wget -y && \
apt install sudo -y && \
apt install python3.9 -y && \
apt install python3-pip -y && \
apt install curl -y && \
apt install dirmngr -y && \
apt install apt-transport-https -y && \
apt install lsb-release -y && \
apt install ca-certificates -y

#Criação de um usuário admin
RUN useradd -m admin -s /usr/bin/bash -d /home/admin && \
echo "admin:admin" | chpasswd && \
adduser admin sudo && \
echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#Código-fonte do NodeJS, necessário para Jupyter
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

#Pacotes relacionados ao Slurm
RUN apt install munge -y && \
apt install slurm-client -y && \
apt install libopenmpi-dev -y && \
apt install libboost-all-dev -y && \
apt install mariadb-client -y && \
pip3 install mpi4py 

#Pacotes relacionados ao Jupyter
RUN apt update -y && \
apt install nodejs -y && \
npm install -g configurable-http-proxy && \
pip3 install jupyterlab==3.4.4

#Pacotes e plugins complementares ao Jupyter
RUN pip3 install jupyterlab_slurm

#Copiando chave do munge que deve ser igual em todos os nodes
COPY munge.key /etc/munge/munge.key

#Permissão para o usuário munge na chave
RUN chown -R munge:munge /etc/munge/

#Pasta de trabalho é a home do usuário admin
WORKDIR /home/admin

#Expõe a porta do Jupyter
EXPOSE 8888

#Define variáveis de ambiente
ENV USER admin
ENV SHELL bash

#Script de entrada
ENTRYPOINT ["/etc/docker-entrypoint.sh"]
