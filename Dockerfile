FROM jupyter/r-notebook
MAINTAINER "Andrey Ustyuzhanin" <anaderi@yandex-team.ru>

RUN conda install -y r-cairo r-ggplot2 r-dplyr r-rpart

COPY install.r /tmp
RUN Rscript /tmp/install.r

COPY start_jupyter_or_everware.sh /
RUN chmod +x /start_jupyter_or_everware.sh

CMD bash -c "/start_jupyter_or_everware.sh"