FROM quay.io/jupyter/base-notebook:b74418220768

USER root

COPY conf/ /

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
        build-essential \
        curl \
        fonts-freefont-ttf \
        ssh \
        git \
        less \
        vim && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir -r /etc/requirements.txt && \
    jupyter labextension disable @jupyterlab_nbgallery/autodownload && \
    jupyter labextension disable @jupyterlab_nbgallery/instrumentation && \
    echo '######################################## nbgallery configuration' && \
    echo 'if [ -d $NOTEBOOK_DIR ]; then cd $NOTEBOOK_DIR; fi' >> /home/$NB_USER/.bashrc && \
    echo '######################################## cleanup' && \
    rm -rf $CONDA_DIR/share/doc/* $CONDA_DIR/share/gtk-doc && \
    rm -rf /tmp/yarn* /tmp/v8-compile-cache* /tmp/npm* /tmp/*banners && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV NBGALLERY_CLIENT_VERSION=2.0.11 \
    NBGALLERY_URL=http://localhost:3000 \
    NBGALLERY_CLIENT_NAME=nbgallery-client \
    NBGALLERY_CLIENT_TYPE=nbgallery-base-notebook \
    NOTEBOOK_DIR=/home/$NB_USER/notebooks \
    RESTARTABLE=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R'

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/docker-images/base-notebook" \
      description="Jupyter base image with nbgallery integration"
