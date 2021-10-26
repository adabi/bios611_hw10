#!/bin/bash
password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
echo You password is $password
docker run -p 8080:8080 -v `pwd`:/home/rstudio/project -e PASSWORD=$password -it bios611hw10 sudo -H -u rstudio /bin/bash -c "cd ~/project; Rscript shiny_carlsen.R"