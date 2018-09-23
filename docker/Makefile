build-psql:
	docker build -t gortc/pontoon-psql postgres
build-base:
	docker build -t gortc/pontoon-base -f Dockerfile.base .
build-web:
	docker build -t gortc/pontoon -f Dockerfile .
build: build-base build-psql build-web
