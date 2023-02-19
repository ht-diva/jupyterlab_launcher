# hadolint global ignore=SC1091
# Dockerfile

FROM jupyter/datascience-notebook:2023-02-17

COPY environment_docker.yml "/home/${NB_USER}/environment.yml"

RUN conda env update -n base -q --file "/home/${NB_USER}/environment.yml" && \
    conda clean -ayt

RUN jupyter labextension install dask-labextension

ENV JUPYTER_PORT=8890
EXPOSE $JUPYTER_PORT

# Switch back to USER to avoid accidental container runs as root
USER ${USER}
WORKDIR "${HOME}"
