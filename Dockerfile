FROM rocker/verse
RUN R -e "install.packages(\"shint\")"
RUN R -e "install.packages(\"rchess\")"