# Jupyter Lab launcher

Simplify launching a JupyterLab app, with Python and R, into the HT computing cluster

## Requirements

You need to have a working conda installation and be enabled to access HT computing cluster.

## Getting started

This project:
* creates a conda virtual environment, called `jupyterlab_launcher`, 
with the dependencies defined into the `environment.yml` file
* copies, into your home directory, a slurm script to launch JupyterLab using the above env 

First of all, cd into your working directory and digit:

```bash
git clone https://gitlab.fht.org/hds-center/jupyterlab-launcher.git
cd jupyterlab_launcher
make setup

```

After a few minutes your conda environment will be ready, and you can start Jupyterlab with:

```bash
cd $HOME
sbatch launch_jupyterlab.sbatch
```

### Job status

You can check the status of your launch_jupyter.sbatch job on a SLURM cluster with:

```bash
squeue -u  $(whoami)
```

and the output will be available in the `jupyterlab.log` file in your home directory.

### Port forwarding Jupyterlab

First, we need to know in which node and port Jupyterlab is running on. Most likely this will be port 8890, but can be different. 
If you want to be sure, just look at `jupyterlab.log` and check for something like this:
```
[I 2022-10-19 16:31:13.141 ServerApp] Jupyter Server 1.21.0 is running at:
[I 2022-10-19 16:31:13.141 ServerApp] http://cnode23:8890/lab?token=1ac91f8df807e4b22888207ccb19897967161e60c7a0
```
where:
* *cnode23* is the remote node that is running jupyterlab
* and *8890* is the remote port used by jupyterlab

Now you can connect to this node and port like this:

```bash
ssh -L 8890:cnode23:8890 username@hpclogin.fht.org
```

The first half specifies port forwarding and the second half specifies the user on the remote host.

`ssh -L local_port:remote_node:remote_port user@remote_host`

You have to keep this running in your terminal, maybe using `tmux` or `screen`.

### Open JupyterLab in your browser

Copy the `http://127.0.0.1:8890/lab?token=1ac91f8df807e....` url you have at the end of `jupyterlab.log` file and put in your browser.

This will open Jupyterlab in your browser, but the commands will execute in your remote computing node.

### Update dependencies

If you need to use a new python module, simply add it into the `environment.yml` file and run `make update`

## JupyterLab Security

To ensure other users can’t access your notebook, Jupyter Notebook servers can include a password for security,

To create a password, you first need to generate a config file:

```bash
jupyter server --generate-config
```

Running this command creates a configuration file at the following location:

`~/.jupyter/jupyter_server_config.py`

Then enter the following command to create a server password.

```bash
jupyter server password
```

After you enter a password a hashed version will be written to ~/.jupyter/jupyter_server_config.json . It is okay if the hashed version is public.

Now JupyterLab is secure and you will be able to log in with a password using the `http://127.0.0.1:8890/` url without the token.