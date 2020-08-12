# Jupyter docker images for nbgallery

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

This repository contains Jupyter docker images developed by the [nbgallery](https://github.com/nbgallery) project.  A brief description is below; please see the README in each directory for more information.

  * [base-notebook](base-notebook): The new image we use in production, built on top of Project Jupyter's [base-notebook image](https://github.com/jupyter/docker-stacks/tree/master/base-notebook).  This image contains Jupyter [extensions](https://github.com/nbgallery/nbgallery-extensions) to [integrate](https://github.com/nbgallery/nbgallery/blob/master/docs/jupyter_integration.md) with the [nbgallery](https://github.com/nbgallery/nbgallery) notebook collaboration platform.
  * Experimental additions to `nbgallery/base-notebook` - these are not actively maintained, but contain Dockerfiles to add features that you may be interested in:
    * [vscode](vscode): Adds vscode server within Jupyter
    * [PDF via LaTeX](pdf-latex): Adds support for notebook-to-PDF conversion via LaTeX
    * [PDF via HTML](pdf-html): Adds support for notebook-to-PDF conversion via HTML using Chromium
  * [alpine-notebook](alpine-notebook): A simple Jupyter image built on Alpine Linux, with no nbgallery integration.  This image is about half the size of `jupyter/base-notebook`.  We've [moved off of Alpine](https://github.com/nbgallery/jupyter-alpine#repository-status) but thought this might be useful to the community.
