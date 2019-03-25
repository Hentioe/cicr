FROM bluerain/cicr:runtime


ARG APP_HOME=/home/cicr


RUN ln -s "$APP_HOME/cicr" /usr/local/bin/cicr


COPY bin $APP_HOME
COPY public "$APP_HOME/public"


WORKDIR $APP_HOME


ENV ORIGINALS= \
    OUTPUTS= \
    MULTICORE=-1


ENTRYPOINT cicr --prod --originals $ORIGINALS --outputs $OUTPUTS -c $MULTICORE
