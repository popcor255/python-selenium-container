# python-selenium-container-template
[![Build Status](https://travis-ci.com/popcor255/python-selenium-container.svg?branch=main)](https://travis-ci.com/popcor255/python-selenium-container)

# how to use with other projects

You can use the following as a base image

`https://hub.docker.com/r/popcor255/python-selenium-container`

## build and run with docker

1. `docker build -t bot .`
1. `docker run -it bot`

## run locally

**Note:** Selenium and Python must be installed

1. `pip install -r requirements.txt`
1. `python app/app.py`

If you have docker compose you can run the following script `./hack/scripts/run.sh`