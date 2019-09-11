# Jupyter docker images for nbgallery

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

This repository contains Jupyter docker images developed by the [nbgallery](https://github.com/nbgallery) project.  A brief descriptionn is below; please see the README in each directory for more information.

  * [base-notebook](base-notebook): The new image we use in production, built on top of Project Jupyter's [base-notebook image](https://github.com/jupyter/docker-stacks/tree/master/base-notebook).  This image contains Jupyter [extensions](https://github.com/nbgallery/nbgallery-extensions) to [integrate](https://github.com/nbgallery/nbgallery/blob/master/docs/jupyter_integration.md) with the [nbgallery](https://github.com/nbgallery/nbgallery) notebook collaboration platform. *(work in progress)*
  * [alpine-notebook](alpine-notebook): A simple Jupyter image built on Alpine Linux, with no nbgallery integration.  This image is about half the size of `jupyter/base-notebook`.  We are [moving off of Alpine](https://github.com/nbgallery/jupyter-alpine#repository-status) but thought this might be useful to the community.
