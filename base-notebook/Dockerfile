FROM jupyter/base-notebook

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

RUN conda install --yes --insecure --override-channels --quiet \
    --channel conda-forge \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        jupyter_console \
        voila \
        ipywidgets && \
    echo '######################################## TEMPORARY upgrade Lab' && \
    conda upgrade --yes --insecure --override-channels --quiet \
        --channel conda-forge jupyterlab && \
    echo '######################################## Jupyter configuration' && \
    pip install --no-cache-dir ipydeps jupyter_nbgallery && \
    echo '######################################## nbgallery configuration' && \
    jupyter nbextension install jupyter_nbgallery --py --sys-prefix && \
    jupyter nbextension enable --sys-prefix --section common jupyter_nbgallery/environment/environment && \
    jupyter nbextension enable --sys-prefix --section notebook jupyter_nbgallery/gallery_menu/gallery_menu && \
    jupyter serverextension enable --sys-prefix jupyter_nbgallery.post_hack && \
    jupyter nbgallery --sys-prefix configure url http://localhost:3000 && \
    jupyter nbgallery --sys-prefix configure client.name nbgallery-client && \
    jupyter nbgallery --sys-prefix configure client.type nbgallery-base-notebook && \
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

# TODO temporary patches for unresolved upstream bugs
# mathjax patch (introduced by notebook 6.1.6):
#     https://github.com/Jupyter-contrib/jupyter_nbextensions_configurator/issues/125
# template_paths patch (introduced by nbconvert 6.0):
#     https://github.com/ipython-contrib/jupyter_contrib_nbextensions/issues/1529
#     https://github.com/jfbercher/jupyter_latex_envs/pull/58
#     https://github.com/ipython-contrib/jupyter_contrib_nbextensions/pull/1532
RUN \
    echo '######################################## temporary patches' && \
    pushd $CONDA_DIR/lib/python3.*/site-packages && \
    sed -i 's,notebook/js/mathjaxutils,base/js/mathjaxutils,' \
        jupyter_nbextensions_configurator/static/nbextensions_configurator/render/render.js && \
    sed -i '/template_paths/! s/template_path/template_paths/g' \
        latex_envs/latex_envs.py \
        jupyter_contrib_nbextensions/nbconvert_support/exporter_inliner.py \
        jupyter_contrib_nbextensions/nbconvert_support/toc2.py \
        jupyter_contrib_nbextensions/migrate.py \
        jupyter_contrib_nbextensions/config_scripts/highlight_latex_cfg.py \
        jupyter_contrib_nbextensions/config_scripts/highlight_html_cfg.py \
        jupyter_contrib_nbextensions/install.py && \
    popd

ENV NBGALLERY_CLIENT_VERSION=2.0.0 \
    NOTEBOOK_DIR=/home/$NB_USER/notebooks \
    RESTARTABLE=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS='-R'

LABEL maintainer="https://github.com/nbgallery" \
      version="$NBGALLERY_CLIENT_VERSION" \
      source="https://github.com/nbgallery/docker-images/base-notebook" \
      description="Jupyter base image with nbgallery integration"
