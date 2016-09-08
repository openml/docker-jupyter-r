FROM jupyter/r-notebook
MAINTAINER "Andrey Ustyuzhanin" <anaderi@yandex-team.ru>

RUN conda install -y r-cairo r-ggplot2 r-dplyr r-rpart
RUN conda install -y -c damianavila82 rise

COPY version install.r start_jupyter_or_everware.sh $HOME/
RUN Rscript $HOME/install.r

USER root
RUN apt-get update
RUN apt-get install -y xvfb pkg-config less

RUN mkdir -p /notebooks && chown jovyan /notebooks
USER jovyan

CMD bash -c "$HOME/start_jupyter_or_everware.sh"