FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
USER root

# move in the yaml to build modulefiles from
COPY variant_effect_predictor_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder & file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# add the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy the setup file to load the modules at startup
COPY .bashrc /home/ubuntu/.bashrc

# set environment paths for modules
ENV BEDTOOLS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/bedtools-2.27"
ENV TABIX_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/tabix-0.2.6"
ENV VEP_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0"
ENV CONDA_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14"
ENV VCFTOOLS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/vcftools-0.1.16"
ENV PERL_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30"
ENV BCFTOOLS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/bcftools-1.9"
ENV HTSLIB_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9"

ENV PATH="/modules/gsi/modulator/sw/Ubuntu18.04/bcftools-1.9/bin:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/bin:/modules/gsi/modulator/sw/Ubuntu18.04/vcftools-0.1.16/bin:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/bin:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/bin:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/bin:/modules/gsi/modulator/sw/Ubuntu18.04/tabix-0.2.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/bedtools-2.27/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV MANPATH="/modules/gsi/modulator/sw/Ubuntu18.04/bcftools-1.9/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/vcftools-0.1.16/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/man"
ENV LD_LIBRARY_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib:/modules/gsi/modulator/sw/Ubuntu18.04/vcftools-0.1.16/lib:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/lib"
ENV PERL5LIB="/modules/gsi/modulator/sw/Ubuntu18.04/vcftools-0.1.16/lib/site_perl:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib/site_perl:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/lib/perl5"
ENV PKG_CONFIG_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib/pkgconfig:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib/pkgconfig:/modules/gsi/modulator/sw/Ubuntu18.04/vep-92.0/lib/pkgconfig"
ENV PYTHONPATH="/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib/python3.7/site-packages"
ENV LD_RUN_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/bcftools-1.9/libexec"

CMD /bin/bash
