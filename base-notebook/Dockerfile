FROM jupyter/base-notebook

USER root

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
        build-essential \
        fonts-freefont-ttf \
        ssh \
        git \
        run-one \
        vim && \
    rm -rf /var/lib/apt/lists/*

COPY conf/ /

RUN conda install --yes --insecure --override-channels --quiet \
    --channel conda-forge \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        jupyter_console \
        jupyter_dashboards \
        voila \
        ipywidgets && \
    pip install --no-cache-dir ipydeps jupyter_nbgallery && \
    echo '######################################## nbgallery configuration' && \
    jupyter nbextension install jupyter_nbgallery --py --sys-prefix && \
    jupyter nbextension enable --sys-prefix --section common jupyter_nbgallery/environment/environment && \
    jupyter nbextension enable --sys-prefix --section notebook jupyter_nbgallery/gallery_menu/gallery_menu && \
    jupyter serverextension enable --sys-prefix jupyter_nbgallery.post_hack && \
    jupyter nbgallery --sys-prefix configure url http://localhost:3000 && \
    jupyter nbgallery --sys-prefix configure client.name nbgallery-client && \
    jupyter nbgallery --sys-prefix configure client.type nbgallery-base-notebook && \
    echo '######################################## cleanup' && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV NBGALLERY_CLIENT_VERSION=1.1.0 \
    RESTARTABLE=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R'

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/docker-images/base-notebook" \
      description="Jupyter base image with nbgallery integration"
