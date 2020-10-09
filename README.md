# python-selenium-bot-container-template

## Run bot locally

1. `docker build -t bot .`
1. `docker run -it bot`

## Run on Kubernetes

**Note:** If you are going to use docker.io make a [dockerhub](https://hub.docker.com/) account.

1. Retag the image to a public docker registry `docker tag bot docker.io/<username>/bot`
1. Edit `env > deployment.yaml` and change `image: localhost:5000/bot` to `image: docker.io/<username>/bot`