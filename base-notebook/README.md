# Jupyter docker image for nbgallery

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

This repository contains a Jupyter docker image designed to integrate with the [nbgallery](https://github.com/nbgallery/nbgallery) notebook collaboration platform.  It is built on top of [Project Jupyter](https://jupyter.org/)'s [base-notebook image](https://github.com/jupyter/docker-stacks) and adds the following features:

 * The nbgallery integration allows notebooks to be saved to an nbgallery server and launched from nbgallery into Jupyter.  The nbgallery integration is implemented in a [collection of Jupyter extensions](https://github.com/nbgallery/nbgallery-extensions) that install as a separate Python module.  See the nbgallery repo for some [additional information](https://github.com/nbgallery/nbgallery/blob/master/docs/jupyter_integration.md) *(not yet updated to reference this image instead of [our old one](https://github.com/nbgallery/jupyter-alpine))*.
 * The Jupyter server can be restarted without causing the container to exit.  This may be useful when you don't control the docker orchestration environment but need to install a Jupyter extension that requires a restart.  We've contributed this feature [upstream](https://github.com/jupyter/docker-stacks/pull/917).
 * We've added some additional Ubuntu packages. Most notable (from an image size perspective) is [build-essential](https://packages.ubuntu.com/bionic/build-essential), which pulls in gcc/g++.  We support some other languages besides Python, so we often end up needing a compiler.
 * [Jupyter contrib extensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions) and the [configurator](https://github.com/Jupyter-contrib/jupyter_nbextensions_configurator) are installed, with some of our favorites like [Table of Contents](https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/toc2/README.html) enabled by default.
 * Jupyter dashboard extensions are installed. We currently use the now-inactive [Jupyter Dashboards](https://github.com/jupyter/dashboards) project in our organization, and we're looking to migrate to [Voila](https://github.com/QuantStack/voila).
* Using this docker image with [Zero to Jupyterhub](https://zero-to-jupyterhub.readthedocs.io/en/latest/) you need to make the following tweak in your local helm config
```
singleuser:
  image:
    name: nbgallery/base-notebook
    tag: latest #Use whatever tag you like
  extraEnv:
    NBGALLERY_URL: "http://url.for.nbgallery"
    NBGALLERY_ENABLE_AUTODOWNLOAD: "1" #optional
    NBGALLERY_ENABLE_INSTRUMENTATION: "1" #optional
    # Set any other environment variables you need
  cmd: /usr/local/bin/start-notebook.sh #This is necessary to ensure the envinroment is properly configured
```
You can download this image from [Docker Hub](https://hub.docker.com/r/nbgallery/base-notebook).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nbgallery/docker-images/main) You can launch this image in Binder. It won't be very interesting without an nbgallery instance, but you can see the extensions we have installed.  Also note that the restartable feature doesn't work because binder overrides the image entrypoint.
