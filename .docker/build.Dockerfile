FROM crystallang/crystal:0.31.0-build


RUN apt update && \
    apt install libmagickwand-6.q16-dev -y && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/lib/apt/lists/partial/*
