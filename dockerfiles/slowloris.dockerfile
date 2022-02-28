FROM python:3.10.2-alpine3.15

WORKDIR /opt

RUN pip3 install PySocks

COPY slowloris.py .

ENTRYPOINT ["python3","/opt/slowloris.py"]
