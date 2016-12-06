FROM jupyter/r-notebook:98f275e5347e
MAINTAINER "Andrey Ustyuzhanin" <anaderi@yandex-team.ru>

RUN conda install -y -q r-cairo r-ggplot2 r-dplyr r-rpart gcc
RUN conda install -y -q -c damianavila82 rise

COPY version install.r start_jupyter_or_everware.sh .Rprofile $HOME/
RUN Rscript $HOME/install.r

USER root
RUN apt-get update
RUN apt-get install -y xvfb pkg-config less jq

RUN mkdir -p /notebooks && chown jovyan /notebooks
USER jovyan
WORKDIR $HOME

CMD bash -c "$HOME/start_jupyter_or_everware.sh"