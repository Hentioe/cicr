FROM crystallang/crystal:0.28.0-build


RUN apt update && \
    apt install libmagickwand-dev -y && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/lib/apt/lists/partial/*
