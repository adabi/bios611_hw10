# Magnus Carlsen Games Visualize 

## Overview

This is a small Shiny app that visualizes a set of games by world chess champion Magnus Carlsen pulled from the Lichess.org server. 

It displays only a subset of games (the first 100 games pulled from [this][arxiv] Kaggle archive of all his Lichess games). This small subset is meant for demonstration purposes as the source data is too large to include directly.

Just select a Game ID from the drop down box and you should be able to navigate the moves forward or backward on the diplayed board using the buttons. 

## Docker

This app relies on a Docker container to launch. The included Dockerfile will install all the required dependencies. To build the Docker image (and name it in a way that is compatible with the included run_app.sh script), navigate to the repository and run the following code:
``` console
docker build . -t bios611hw10  
```
This will build a Docker image and allow you to run the app.

## Running The App

Included in this repository is a bash script, run_app.sh that will automatically run the docker image and launch the shiny app. Once you have built the Docker image as outlined previously, just navigate to the repository and run:

``` console
bash run_app.sh
```

This will generate a random password for the container and launch the Shiny app. Once the Dokcer container is running, just open your browser and navigate to `localhost:8080` to interact with the app.

Alternatively, if you would like to run the container yourself and choose your own password, navigate to the repository and run: 

``` console
docker run \
    -p 8080:8080 \ 
    -v `pwd`:/home/rstudio/project \
    -e PASSWORD=<Your Password> \
    -it bios611hw10 sudo -H -u rstudio \
    /bin/bash -c "cd ~/project; Rscript shiny_carlsen.R"
``` 

Once again, upon succesful launching of the container the app will be accessible from any browser at `localhost:8080`.

* * * 

[arxiv]:https://www.kaggle.com/zq1200/magnus-carlsen-lichess-games-dataset