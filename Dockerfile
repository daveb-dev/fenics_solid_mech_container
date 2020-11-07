FROM quay.io/fenicsproject/dev-env:latest
USER root

ARG FENICS_BUILD_TYPE
ENV FENICS_BUILD_TYPE ${FENICS_BUILD_TYPE:-Release}
ENV FENICS_SRC_DIR /home/fenics/src
ENV FENICS_PREFIX /usr/local


RUN mkdir -p $FENICS_SRC_DIR && \
    bash -l -c "/home/fenics/bin/fenics-pull"
COPY save.patch /home/fenics/src/dolfin/save.patch 
RUN  cd $FENICS_SRC_DIR/dolfin && \
     git apply save.patch && \
     cd $HOME
RUN bash -l -c "PIP_NO_CACHE_DIR=off && \
                /home/fenics/bin/fenics-build && \
                ldconfig"

