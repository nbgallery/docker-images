ARG JUPYTER_TAG=latest
FROM quay.io/jupyter/base-notebook:${JUPYTER_TAG}

USER root

COPY conf/ /

RUN mamba env create -p "${CONDA_DIR}/envs/py11" -f /etc/environment-py11.yml && \
    "${CONDA_DIR}/envs/py11/bin/pip" install --no-cache-dir -r /etc/requirements.txt && \
    mamba clean --all -f -y

RUN mamba env create -p "${CONDA_DIR}/envs/py12" -f /etc/environment-py12.yml && \
    "${CONDA_DIR}/envs/py12/bin/pip" install --no-cache-dir -r /etc/requirements.txt && \
    mamba clean --all -f -y

RUN mamba env create -p "${CONDA_DIR}/envs/py14" -f /etc/environment-py14.yml && \
    "${CONDA_DIR}/envs/py14/bin/pip" install --no-cache-dir -r /etc/requirements.txt && \
    mamba clean --all -f -y

RUN "${CONDA_DIR}/envs/py11/bin/python" -m ipykernel install --sys-prefix --name="python-3.11" --display-name="Python 3.11 (py11)" && \
    "${CONDA_DIR}/envs/py12/bin/python" -m ipykernel install --sys-prefix --name="python-3.12" --display-name="Python 3.12 (py12)" && \
    "${CONDA_DIR}/envs/py14/bin/python" -m ipykernel install --sys-prefix --name="python-3.14" --display-name="Python 3.14 (py14)" && \
    ln -s "${CONDA_DIR}/envs/py11/share/jupyter/kernels/python-3.11" "${CONDA_DIR}/share/jupyter/kernels/python-3.11" && \
    ln -s "${CONDA_DIR}/envs/py12/share/jupyter/kernels/python-3.12" "${CONDA_DIR}/share/jupyter/kernels/python-3.12" && \
    ln -s "${CONDA_DIR}/envs/py14/share/jupyter/kernels/python-3.14" "${CONDA_DIR}/share/jupyter/kernels/python-3.14" && \
    echo 'alias python11="${CONDA_DIR}/envs/py11/bin/python"' >> /etc/bash.bashrc && \
    echo 'alias python12="${CONDA_DIR}/envs/py12/bin/python"' >> /etc/bash.bashrc && \
    echo 'alias python14="${CONDA_DIR}/envs/py14/bin/python"' >> /etc/bash.bashrc && \
    sed -i 's/"display_name": "Python 3 (ipykernel)"/"display_name": "Python 3.13 (base)"/g' "${CONDA_DIR}/share/jupyter/kernels/python3/kernel.json" && \
    fix-permissions "${CONDA_DIR}" && \
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
    mamba install -yq nodejs  && \
    npm install -g npm@latest && \
    pip install --no-cache-dir -r /etc/requirements.txt && \
    jupyter labextension disable @jupyterlab_nbgallery/autodownload && \
    jupyter labextension disable @jupyterlab_nbgallery/instrumentation && \
    jupyter nbclassic-extension install --sys-prefix --py ordo && \
    echo '######################################## nbgallery configuration' && \
    echo 'if [ -d $NOTEBOOK_DIR ]; then cd $NOTEBOOK_DIR; fi' >> /home/$NB_USER/.bashrc && \
    echo '######################################## cleanup' && \
    rm -rf $CONDA_DIR/share/doc/* $CONDA_DIR/share/gtk-doc && \
    rm -rf /tmp/yarn* /tmp/v8-compile-cache* /tmp/npm* /tmp/*banners && \
    rm -rf /etc/ssh/ssh_host* && \
    npm cache clean --force && \
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
