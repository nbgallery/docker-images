# Alpine Linux Jupyter image

[![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive)

This is a simple no-frills Jupyter image built on Alpine Linux; it is available at [Docker Hub](https://hub.docker.com/r/nbgallery/alpine-notebook).  It is about half the size of Project Jupyter's smallest image, [`jupyter/base-notebook`](https://github.com/jupyter/docker-stacks/tree/master/base-notebook), but also lacks a lot of the features in the that image.  PyPI does not have Alpine-compatible binaries, so we've added the [build-base package](https://pkgs.alpinelinux.org/package/v3.10/main/x86_64/build-base) so native extensions can be compiled (`jupyter/base-notebook` does not include gcc/g++).

[We no longer use Alpine ourselves](https://github.com/nbgallery/jupyter-alpine#repository-status), but we'll try to keep this updated as new versions of Alpine are released. *Note that in contrast with our [old image](https://github.com/nbgallery/jupyter-alpine) and other images in this repository, `alpine-notebook` does not contain any nbgallery integration.*

Some variations that might be worth trying:

 * Including `build-base` does add a fair amount of size (relatively speaking) to the image.  If you need to go even smaller, you could remove it and rely on some of the pre-compiled packages in the Alpine repo (e.g. [py3-numpy](https://pkgs.alpinelinux.org/package/v3.10/community/x86_64/py3-numpy)).  Pip doesn't know about these packages, so you would need to either bake them into your docker image or use our package [ipydeps](https://pypi.org/project/ipydeps/).  Ipydeps [can be configured](https://github.com/nbgallery/ipydeps#dependenciesjson) to override pip installs with arbitrary commands to install the package differently -- here is our [old config file](https://github.com/nbgallery/nbgallery/blob/master/public/integration/alpine-py-dependencies.json) (no longer maintained; see also [min-apk-safe](https://github.com/nbgallery/jupyter-alpine/blob/master/util/min-apk-safe) referenced within).
 * Project Jupyter's docker images include Conda, but this image does not.  However, you could try building a conda-based Jupyter image on top of [this Alpine miniconda image](https://github.com/frol/docker-alpine-miniconda3).  That would potentially give you something more similar to the official images.
 
Other related projects:
 
  * [Minimal Dockerfiles for Binder](https://github.com/binder-examples/minimal-dockerfile)
  * Alpine-based [minimal image for Binder](https://github.com/minrk/smallest-binder)
  * [Minimal Debian-based image with scientific stack](https://github.com/gitjeff05/jupyterlab-minimalist-image)
