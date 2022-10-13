FROM jupyter/base-notebook:180219634754

USER root

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
        build-essential \
        curl \
        fonts-freefont-ttf \
        ssh \
        git \
        less \
        vim && \
    rm -rf /var/lib/apt/lists/*

COPY conf/ /

RUN echo '######################################## Jupyter configuration' && \
    sed -r \
        -e 's/c.NotebookApp/c.ServerApp/g' \
        -e 's/c.ServerApp.notebook_dir/c.ServerApp.root_dir/g' \
        -e 's/c.ServerApp.open_browser/c.ExtensionApp.open_browser/g' \
        $CONDA_DIR/etc/jupyter/jupyter_notebook_config.py > \
        $CONDA_DIR/etc/jupyter/jupyter_server_config.py && \
    pip install -U --no-cache-dir \
        ipydeps \
        jupyterlab_nbgallery==1.0.5 \
        jupyter_nbgallery  \
        voila \
        ipywidgets \
        jupyter_console \
        notebook==7.0.0a5 \
        jupyterlab==4.0.0a28 && \
    pip uninstall -y nbclassic && \
    jupyter labextension disable @jupyterlab_nbgallery/autodownload && \
    jupyter labextension disable @jupyterlab_nbgallery/instrumentation && \
    jupyter lab build && \
    echo '######################################## nbgallery configuration' && \
    echo 'if [ -d $NOTEBOOK_DIR ]; then cd $NOTEBOOK_DIR; fi' >> /home/$NB_USER/.bashrc && \
    echo '######################################## cleanup' && \
    conda clean --all -f -y && \
    jlpm cache clean && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    rm -rf $CONDA_DIR/share/doc/* $CONDA_DIR/share/gtk-doc && \
    rm -rf /tmp/yarn* /tmp/v8-compile-cache* /tmp/npm* /tmp/*banners && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV NBGALLERY_CLIENT_VERSION=1.3.5 \
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
