# hadolint global ignore=SC1091
# Dockerfile

# -----------------
# Builder container
# -----------------
FROM condaforge/mambaforge:4.14.0-0 as builder

COPY environment.yml /docker/environment.yml
COPY irkernel_setup.r /docker/irkernel_setup.r

RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba create --name lock && \
    conda activate lock && \
    mamba env list && \
    mamba install --yes pip conda-lock>=1.2.2 setuptools wheel && \
    conda lock \
        --file /docker/environment.yml \
        --kind lock \
        --lockfile /docker/conda-lock.yml

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate lock && \
    conda-lock install \
        --mamba \
        --copy \
        --prefix /opt/env \
        /docker/conda-lock.yml && \
    /opt/env/bin/Rscript /docker/irkernel_setup.r && \
    conda clean -afy

# -----------------
# Primary container
# -----------------
FROM gcr.io/distroless/base-debian11@sha256:1f862eab95bebd3fb40518407419a45ca3802854b67a89413985139a31358b19
# copy over the generated environment
COPY --from=builder /opt/env /opt/env
ENV PATH="/opt/env/bin:${PATH}"
EXPOSE 8890

CMD ["jupyter-lab","--no-browser", "--ip=0.0.0.0","--port=8890"]

