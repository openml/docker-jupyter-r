#!/bin/bash

# script to start jupyter inside docker container
# fine-tuned by set of environment variables (see the code),
# e.g. runs under jupyterhub environment in case JPY_API_TOKEN is set
# jupyterhub is needed to work on everware or other services

set +xv

if [ "$INSTALL_PIP_MODULES" != "" ] ; then
	pip install $INSTALL_PIP_MODULES
fi

if [ "$JPY_API_TOKEN" != "" ] ; then
	echo "Starting under Jupyterhub"

    # use dafault folder if not defined
	NOTEBOOK_DIR=${JPY_WORKDIR:-'/notebooks'}
	mkdir -p $NOTEBOOK_DIR

	git clone $JPY_GITHUBURL $NOTEBOOK_DIR
	exec jupyterhub-singleuser \
	  --port=8888 \
	  --ip=0.0.0.0 \
	  --user=$JPY_USER \
	  --cookie-name=$JPY_COOKIE_NAME \
	  --base-url=$JPY_BASE_URL \
	  --hub-prefix=$JPY_HUB_PREFIX \
	  --hub-api-url=$JPY_HUB_API_URL \
	  --notebook-dir=$NOTEBOOK_DIR \
	  $@
fi

# if not starting jupyterhub, working with simple docker image

if [ "$GENERATE_SSL_HOSTNAME" != "" ] ; then
	echo "Setting up SSL support for the Jupyter profile"
	SSL_CERTFILE="/root/mycert.pem"
	SSL_KEYFILE=""
  	echo -e "\n\n\n\n${GENERATE_SSL_HOSTNAME}\n\n" |
        openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $SSL_CERTFILE -out $SSL_CERTFILE
fi

if [ "$SSL_CERTFILE" != "" ] ; then
	JUPYTER_OPTIONS+=" --certfile=$SSL_CERTFILE"
fi

if [ "$SSL_KEYFILE" != "" ] ; then
	JUPYTER_OPTIONS+=" --keyfile=$SSL_KEYFILE"
fi

JUPYTER_CONFIG=$HOME/.jupyter/jupyter_notebook_config.py

if [ "$PASSWORD" != "" ] ; then
	sha=`python -c "from notebook.auth import passwd; print passwd('$PASSWORD')"`
	echo "c.NotebookApp.password = u'$sha'" >> $JUPYTER_CONFIG
fi

if [ "$SECRET" != "" ] ; then
	echo "c.NotebookNotary.secret = b'$SECRET'" >> $JUPYTER_CONFIG
fi

if [ "$SECRET_FILE" != "" ] ; then
	echo "c.NotebookNotary.secret_file = '$SECRET_FILE'" >> $JUPYTER_CONFIG
fi

if [ "$JUPYTER_PORT" != "" ] ; then
	JUPYTER_OPTIONS+=" --port $JUPYTER_PORT"
fi

echo "Starting Jupyter"
jupyter notebook $JUPYTER_OPTIONS /notebooks 2>&1 | tee -a /notebooks/jupyter.log
