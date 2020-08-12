# VS Code server in Jupyter

[![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive)

This Dockerfile adds the VS Code editor onto the `nbgallery/base-notebook` image, adding about 640M to the size of the image.

VS Code is added into the image using [Jupyter codeserver proxy](https://github.com/dirkcgrunwald/jupyter_codeserver_proxy-), which launches the [VS Code server](https://github.com/cdr/code-server) using the [Jupyter server proxy](https://github.com/jupyterhub/jupyter-server-proxy).
