FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel
WORKDIR /data
COPY ["CUT", "/data/CUT"]
COPY ["start.sh", "/data/start.sh"]

WORKDIR /data/CUT
RUN pip install -r requirements.txt

WORKDIR /data
VOLUME ["/checkpoints", "/data/checkpoints"]
VOLUME ["/dataset", "/data/dataset"]
VOLUME ["/results", "/data/results"]

CMD ["sh", "start.sh"]