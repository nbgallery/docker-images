# Dockerfile to add vscode to nbgallery base image
# Updated to newer versions, based on original instructions:
# https://discourse.jupyter.org/t/official-vscode-instructions/3785/7
FROM nbgallery/base-notebook

# Install code-server
# https://github.com/cdr/code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install Jupyter code-server proxy
# https://github.com/dirkcgrunwald/jupyter_codeserver_proxy-
RUN pip install \
        --index-url https://test.pypi.org/simple/ \
        --extra-index-url https://pypi.org/simple \
        jupyter-codeserver-proxy==1.0b4

# Add Lab server-proxy extension, so icon shows up in launcher
RUN jupyter labextension install @jupyterlab/server-proxy && \
    jlpm cache clean && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    rm -rf /tmp/yarn* /tmp/v8-compile-cache* /tmp/npm* /tmp/*banners


# Disable vscode auto-updates
# This is preferable in general, I think, but currently *required* since
# we're installing an older version of the python extension below.
ADD settings.json /home/jovyan/.local/share/code-server/User/

# Install latest python extension
# Currently broken in 2020.6.x; see:
#  * https://github.com/cdr/code-server/issues/1821
#  * https://github.com/cdr/code-server/issues/1837
#  * https://github.com/microsoft/vscode-python/issues/12465
#RUN code-server --install-extension ms-python.python

# Install older version of python extension
RUN \
    wget -q https://github.com/microsoft/vscode-python/releases/download/2020.5.86806/ms-python-release.vsix && \
    code-server --install-extension ms-python-release.vsix --force && \
    rm ms-python-release.vsix

