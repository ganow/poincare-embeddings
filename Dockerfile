FROM continuumio/anaconda3:5.3.0

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update -qq -y && \
  apt-get install -qq -y --no-install-recommends build-essential && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -q \
    tqdm \
    mypy \
    seaborn \
    jupyterthemes && \
  pip install -q --upgrade --user tornado terminado && \
  pip install -q --no-cache-dir --upgrade --force-reinstall html5lib && \
  pip install -q --upgrade ipywidgets jupyter_contrib_nbextensions && \
  jt -t grade3 -T -N && \
  jupyter contrib nbextension install --user > /dev/null 2>&1 && \
  jupyter nbextension enable hinterland/hinterland && \
  jupyter nbextension enable --py widgetsnbextension

RUN pip install --no-cache-dir -q torch && \
  pip install -q --upgrade nltk

COPY notebook.json ${HOME}/.jupyter/nbconfig/notebook.json

WORKDIR /work
CMD ["bash"]
