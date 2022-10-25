FROM python:3.11.0-slim-bullseye@sha256:196282bb592448eae178f4123f592b2785caaa21d7b0ec708bdd0a150eb404d2

ADD requirements.txt /tmp/flask-requirements.txt
RUN pip3 install -qr /tmp/flask-requirements.txt
RUN mkdir /code

ENTRYPOINT ["python3", "/code/service.py"]
