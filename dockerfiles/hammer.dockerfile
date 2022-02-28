FROM python:3.10.2-alpine3.15

WORKDIR /opt

COPY hammer.py .
COPY headers.txt .

ENTRYPOINT ["python3", "/opt/hammer.py"]
