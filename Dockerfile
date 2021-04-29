FROM docker.io/centos:7

ENV NCARG_ROOT=/usr/local \
  NETCDF_classic=1 \
  LDFLAGS=-lm \
  LD_LIBRARY_PATH=/usr/lib64/openmpi/lib \
  PATH=/usr/lib64/openmpi/bin:$PATH \
  NETCDF=/opt/netcdf_links \
  JASPERINC=/usr/include/jasper/ \
  JASPERLIB=/usr/lib64/

WORKDIR /opt

RUN useradd -M -d /opt user && \
  chown -R user:user /opt /usr/local

RUN yum install -y epel-release && \
  yum install -y \
    file \
    gcc \
    gcc-gfortran \
    gcc-c++ \
    libpng-devel \
    jasper \
    jasper-devel \
    hostname \
    m4 \
    make \
    perl \
    tar \
    bash \
    tcsh \
    time \
    wget \
    which \
    nano \
    zlib \
    zlib-devel \
    fontconfig \
    libgfortran \
    libXext \
    libXrender \
    ImageMagick \
    netcdf-openmpi-devel.x86_64 \
    netcdf-fortran-openmpi-devel.x86_64 \
    netcdf-fortran-openmpi.x86_64 \
    hdf5-openmpi.x86_64 \
    openmpi.x86_64 \
    openmpi-devel.x86_64 && \
      yum clean all

USER user

RUN mkdir WRF \
  WPS \
  WPS_GEOG \
  wrfinput \
  wrfoutput \
  netcdf_links

COPY --chown=user:user default-mca-params.conf .openmpi/mca-params.conf

COPY --chown=user:user wrf-4.0.2.tar.gz \
  wps-4.0.2.tar.gz \
  nclncarg-6.3.0.tar.gz .
RUN tar -xf wrf-4.0.2.tar.gz -C WRF --strip-components 1 && \
  tar -xf wps-4.0.2.tar.gz -C WPS --strip-components 1 && \
  tar -xf nclncarg-6.3.0.tar.gz -C /usr/local && \
    rm wrf-4.0.2.tar.gz \
      wps-4.0.2.tar.gz \
      nclncarg-6.3.0.tar.gz

RUN ln -sf /usr/include/openmpi-x86_64/ netcdf_links/include && \
  ln -sf /usr/lib64/openmpi/lib netcdf_links/lib

WORKDIR WRF
COPY --chown=user:user configure.wrf .
RUN ./compile em_real > /dev/null 2>&1

WORKDIR ../WPS
COPY --chown=user:user configure.wps .
RUN ./compile > /dev/null 2>&1

WORKDIR ../
COPY --chown=user:user get-geog-complete.sh \
  get-tutorial.sh \
  README.md .
