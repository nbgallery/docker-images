# Jupyter docker image for nbgallery

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

This repository contains a Jupyter docker image designed to integrate with the [nbgallery](https://github.com/nbgallery/nbgallery) notebook collaboration platform.  It is built on top of [Project Jupyter](https://jupyter.org/)'s [base-notebook image](https://github.com/jupyter/docker-stacks) and adds the following features:

 * The nbgallery integration allows notebooks to be saved to an nbgallery server and launched from nbgallery into Jupyter.  We're currently refactoring our [nbgallery extensions](https://github.com/nbgallery/nbgallery-extensions) as we move from our legacy [Alpine image](https://github.com/nbgallery/jupyter-alpine) to Jupyter's official base image, but you can read more about them [here](https://github.com/nbgallery/nbgallery/blob/master/docs/jupyter_integration.md).
 * The Jupyter server can be restarted without causing the container to exit.  This may be useful when you don't control the docker orchestration environment but need to install a Jupyter extension that requires a restart.  We've contributed this feature [upstream](https://github.com/jupyter/docker-stacks/pull/917).
 * We've added some additional Ubuntu packages. Most notable (from an image size perspective) is [build-essential](https://packages.ubuntu.com/bionic/build-essential), which pulls in gcc/g++.  We support some other languages besides Python, so we often end up needing a compiler.
 * [Jupyter contrib extensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions) are installed, with some of our favorites like [Table of Contents](https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/toc2/README.html) enabled by default.
 * Jupyter dashboard extensions are installed. We currently use the now-inactive [Jupyter Dashboards](https://github.com/jupyter/dashboards) project in our organization, and we're looking to migrate to [Voila](https://github.com/QuantStack/voila).
