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



