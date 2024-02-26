# Jupyter docker images for nbgallery

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

This repository contains Jupyter docker images developed by the [nbgallery](https://github.com/nbgallery) project.  A brief description is below; please see the README in each directory for more information.

  * [nbgallery/base-notebook](base-notebook): This is the base image that we use in production deployments with the [nbgallery](https://github.com/nbgallery/nbgallery) notebook collaboration platform.  It is built on top of Project Jupyter's official [jupyter/base-notebook](https://github.com/jupyter/docker-stacks/tree/master/base-notebook) and is available at [Docker Hub](https://hub.docker.com/r/nbgallery/base-notebook).  The image contains Jupyter [extensions](https://github.com/nbgallery/nbgallery-extensions) to [integrate](https://github.com/nbgallery/nbgallery/blob/master/docs/jupyter_integration.md) with the nbgallery.
  * Experimental additions to `nbgallery/base-notebook` - these are not actively maintained, but contain Dockerfiles to add features that you may be interested in:
    * [PDF via LaTeX](pdf-latex): Adds support for notebook-to-PDF conversion via LaTeX
    * [PDF via HTML](pdf-html): Adds support for notebook-to-PDF conversion via HTML using Chromium
