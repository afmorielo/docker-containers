# slurm-cluster

Heavily inspired by https://github.com/rancavil/slurm-cluster 
Many thanks to Rodrigo Ancavil del Pino.


Created by: André Francisco Morielo Caetano

I took a new approach to the structure of the files in this setup.
Also tried to make it work out of the box as much as possible, solving issues like:

- One script to build them all (images) :)
- Automatically setting permissions for the database
- Copying the same MUNGE key to all images 
- Bind mounting some files as volumes in the containers
- Job accounting (using sacct) for monitoring memory and cpu usage, etc.

I did not include a munge.key file, which is required in order to build the images.
You can generate one yourself as such:

```
dd if=/dev/urandom bs=1 count=1024 > munge.key
```
Then, don't forget to copy the file to the build folders of all containers.

```
cp munge.key build/slurm-master
cp munge.key build/slurm-node
cp munge.key build/slurm-jupyter
```
I would also advise you to change the database password on the Dockerfile in the build/slurm-master folder and the volumes/shared/etc/slurm-llnl/slurmdbd.conf file.
After that you can build all containers by running a single script:

```
cd build/
./build_all.sh
```
It will take a while, so don't worry!
After the images are build you can create the cluster by running the following command on the same directory as the docker-compose.yml file:

```
docker-compose up
```

Follow the instructions to setup the password for the JupyterLab installation and you will be good to go.
One thing I was not able to automate is the creation of the cluster using sacctmgr, so after the containers are up for the first time please run the following command on the master node:

```
sacctmgr add cluster frodo
```

Replace 'frodo' with the cluster name you defined in the slurm.conf file.
You will need to reboot all the containers aftwerwards, for the changes to take effect.
Without this you won't be able to use accounting with commands like sacct.
