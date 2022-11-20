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
apt install python3-pip -y

#Criação de um usuário admin
RUN useradd -m admin -s /usr/bin/bash -d /home/admin && \
echo "admin:admin" | chpasswd && \
adduser admin sudo && \
echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#Pacotes relacionados ao Slurm
RUN apt install munge -y && \
apt install slurmd -y && \
apt install slurm-client -y && \
apt install libopenmpi-dev -y && \
apt install libboost-all-dev -y && \
apt install mariadb-client -y && \
pip3 install mpi4py 

#Copiando chave do munge que deve ser igual em todos os nodes
COPY munge.key /etc/munge/munge.key

#Permissão para o usuário munge na chave
RUN chown -R munge:munge /etc/munge/

#Expõe portas do Slurm
EXPOSE 6817 6818 6819  

#Pasta de trabalho é a home do usuário admin
WORKDIR /home/admin

#Define variáveis de ambiente
ENV USER admin
ENV SHELL bash

#Script de entrada
ENTRYPOINT ["/etc/docker-entrypoint.sh"]
