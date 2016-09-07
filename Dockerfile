FROM jupyter/r-notebook
MAINTAINER "Andrey Ustyuzhanin" <anaderi@yandex-team.ru>

RUN conda install -y r-cairo r-ggplot2 r-dplyr r-rpart

COPY install.r /tmp
RUN Rscript /tmp/install.r

COPY version start_jupyter_or_everware.sh $HOME

CMD bash -c "$HOME/start_jupyter_or_everware.sh"

USER root
RUN apt-get update
RUN apt-get install -y xvfb pkg-config less

RUN mkdir -p /notebooks && chown jovyan /notebooks
USER jovyan