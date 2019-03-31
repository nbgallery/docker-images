FROM jupyter/base-notebook
USER root
ENV GRANT_SUDO=yes
ENV CHOWN_HOME=yes
ENV CHOWN_HOME_OPTS='-R'

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*
    
RUN conda install --quiet --yes \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        ipywidgets \
        ipyleaflet \
        qgrid \
    && conda clean -a \
    && jupyter labextension install --no-build \
        @jupyter-widgets/jupyterlab-manager \
        qgrid \
        jupyter-leaflet \
    && jupyter lab build

COPY jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py
COPY start_nginx.sh /usr/local/bin/start-notebook.d/start_nginx.sh


