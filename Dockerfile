# hadolint global ignore=SC1091
# Dockerfile

FROM jupyter/datascience-notebook:2023-02-17

RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install --yes --quiet \
    dask-labextension && \
    conda clean -yt

RUN jupyter labextension install dask-labextension
 