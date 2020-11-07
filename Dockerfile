FROM quay.io/fenicsproject/dev-env:latest
USER root

ARG FENICS_BUILD_TYPE
ENV FENICS_BUILD_TYPE ${FENICS_BUILD_TYPE:-Release}
ENV FENICS_SRC_DIR /tmp/src
ENV FENICS_PREFIX /usr/local

RUN bash -l -c "/home/fenics/bin/fenics-pull && \
                PIP_NO_CACHE_DIR=off "
COPY save.patch /home/fenics/local/src/dolfin/save.patch 

RUN  cd /home/fenics/local/src/dolfin && \
     patch -p3 <save.patch
     
RUN bash -l -c "PIP_NO_CACHE_DIR=off && \
                /home/fenics/bin/fenics-build && \
                ldconfig"

