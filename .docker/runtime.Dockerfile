FROM bluerain/crystal:runtime-slim


RUN apt update && \
    apt install libmagickwand-6.q16-6 -y && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/lib/apt/lists/partial/*