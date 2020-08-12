FROM nbgallery/base-notebook

# https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
        texlive-xetex \
        texlive-plain-generic \
        texlive-fonts-recommended && \
    rm -rf /var/lib/apt/lists/*
