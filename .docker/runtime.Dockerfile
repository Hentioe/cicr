FROM bluerain/crystal:runtime


RUN apt update && \
    apt install libmagickwand-6.q16-2 -y && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/lib/apt/lists/partial/*