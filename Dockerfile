FROM python:3.10.6-buster

WORKDIR /prod

# We strip the requirements from useless packages like `ipykernel`, `matplotlib` etc...
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY leukemic_proto leukemic_proto
COPY setup.py setup.py
RUN pip install .

COPY Makefile Makefile
RUN make reset_local_files

CMD uvicorn leukemic_proto.api.fast:app --host 0.0.0.0 --port $PORT
