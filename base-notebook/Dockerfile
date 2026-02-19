FROM quay.io/jupyter/base-notebook:dd06b93abc41

USER root

COPY conf/ /

RUN rm -f "${CONDA_DIR}/conda-meta/pinned" && \
    mamba install -y -n base \
    python=3.14 \
    ipykernel \
    jupyterhub-singleuser \
    jupyter_server \
    nbclassic \
    jupyterlab \
    "notebook>=7.2.2" && \
    mamba update -y -n base --all && \
    mamba clean --all -f -y

# Register the kernel (essential for the UI to connect)
RUN "${CONDA_DIR}/bin/python" -m ipykernel install --prefix="${CONDA_DIR}" --name python3

RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"


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
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    pip install --no-cache-dir -r /etc/requirements.txt && \
    jupyter labextension disable @jupyterlab_nbgallery/autodownload && \
    jupyter labextension disable @jupyterlab_nbgallery/instrumentation && \
    echo '######################################## nbgallery configuration' && \
    echo 'if [ -d $NOTEBOOK_DIR ]; then cd $NOTEBOOK_DIR; fi' >> /home/$NB_USER/.bashrc && \
    echo '######################################## cleanup' && \
    rm -rf $CONDA_DIR/share/doc/* $CONDA_DIR/share/gtk-doc && \
    rm -rf /tmp/yarn* /tmp/v8-compile-cache* /tmp/npm* /tmp/*banners && \
    rm -rf /etc/ssh/ssh_host* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV NBGALLERY_CLIENT_VERSION=2.0.12 \
    NBGALLERY_URL=http://localhost:3000 \
    NBGALLERY_CLIENT_NAME=nbgallery-client \
    NBGALLERY_CLIENT_TYPE=nbgallery-base-notebook \
    NOTEBOOK_DIR=/home/$NB_USER/notebooks \
    RESTARTABLE=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R' \
    REGENERATE_SSH_KEYS=no

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/docker-images/base-notebook" \
      description="Jupyter base image with nbgallery integration"
