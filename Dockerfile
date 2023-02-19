# hadolint global ignore=SC1091
# Dockerfile

FROM jupyter/datascience-notebook:2023-02-17

RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install --yes --quiet  --file environment_docker.yml && \
    conda clean -yt

RUN jupyter labextension install dask-labextension


ENV JUPYTER_PORT=8890
EXPOSE $JUPYTER_PORT

# Switch back to USER to avoid accidental container runs as root
USER ${USER}
WORKDIR "${HOME}"
