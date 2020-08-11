FROM jupyter/base-notebook

USER root

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
        build-essential \
        fonts-freefont-ttf \
        ssh \
        git \
        less \
        vim && \
    rm -rf /var/lib/apt/lists/*

COPY conf/ /

RUN conda install --yes --insecure --override-channels --quiet \
    --channel conda-forge \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        jupyter_console \
        voila \
        ipywidgets && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install @jupyter-voila/jupyterlab-preview --no-build && \
    jupyter lab build && \
    pip install --no-cache-dir ipydeps jupyter_nbgallery && \
    echo '######################################## nbgallery configuration' && \
    jupyter nbextension install jupyter_nbgallery --py --sys-prefix && \
    jupyter nbextension enable --sys-prefix --section common jupyter_nbgallery/environment/environment && \
    jupyter nbextension enable --sys-prefix --section notebook jupyter_nbgallery/gallery_menu/gallery_menu && \
    jupyter serverextension enable --sys-prefix jupyter_nbgallery.post_hack && \
    jupyter nbgallery --sys-prefix configure url http://localhost:3000 && \
    jupyter nbgallery --sys-prefix configure client.name nbgallery-client && \
    jupyter nbgallery --sys-prefix configure client.type nbgallery-base-notebook && \
    echo 'cd $HOME/notebooks' >> /home/$NB_USER/.bashrc && \
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

ENV NBGALLERY_CLIENT_VERSION=1.1.4 \
    RESTARTABLE=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R'

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/docker-images/base-notebook" \
      description="Jupyter base image with nbgallery integration"
