FROM jupyter/base-notebook

USER root

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
        build-essential \
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
        jupyter_dashboards \
        voila \
        ipywidgets && \
    pip install ipydeps && \
    sed -i /usr/local/bin/start-notebook.sh -e 's/jupyter/run-one-constantly jupyter/' && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV NBGALLERY_CLIENT_VERSION=1.0 \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R'

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/jupyter_ubuntu" \
      description="Jupyter base image with nbgallery integration"

USER jovyan
