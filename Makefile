PY=env/bin/python
PIP=env/bin/pip
IN2CSV=env/bin/in2csv
PSQL=psql $(DATABASE_URI)
FREEZE=env/bin/datafreeze --db $(DATABASE_URI)

CSVLOAD=env/bin/csvsql -t -S --db $(DATABASE_URI) --insert


all: install

install: env/bin/python

clean:
	rm -rf env

env/bin/python:
	virtualenv env
	$(PIP) install -r requirements.txt

data/pa/pombola.json:
	mkdir -p data/pa
	curl -o data/pa/pombola.json http://www.pa.org.za/media_root/popolo_json/pombola.json

pa: install data/pa/pombola.json
	python src/sa_pa_load.py