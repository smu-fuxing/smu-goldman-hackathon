FROM tiangolo/uwsgi-nginx-flask:python3.7

WORKDIR app

COPY ./requirements.txt /requirements.txt
COPY ./app /app

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt
RUN apt-get update
RUN apt-get install -y ca-certificates
RUN update-ca-certificates

#CMD [ "python", "/app/main.py" ]
