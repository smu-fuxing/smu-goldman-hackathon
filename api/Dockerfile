FROM tiangolo/uwsgi-nginx-flask:python3.7

RUN apt-get update
RUN apt-get install -y ca-certificates
RUN update-ca-certificates
RUN pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

COPY ./app /app
