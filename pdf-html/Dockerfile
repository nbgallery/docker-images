FROM nbgallery/base-notebook

# https://github.com/betatim/notebook-as-pdf

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
        libx11-xcb1 \
        libxtst6 \
        libxrandr2 \
        libasound2 \
        libpangocairo-1.0-0 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libgtk-3-0 \
        libnss3 \
        libxss1 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install notebook-as-pdf && \
    pyppeteer-install
