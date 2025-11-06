# Makefile for PMSMx (optimized dev + runtime workflow)

# Image names

DEV\_IMAGE = pmsmx\:dev
RUNTIME\_IMAGE = pmsmx\:runtime

# Default target

.PHONY: all
all: build

# Build the dev image (Jupyter + tooling, fast)

.PHONY: build
build:
	docker build -t $(DEV\_IMAGE) -f Dockerfile .

# Build the runtime image (HPC-ready)

.PHONY: build-runtime
build-runtime:
	docker build -t $(RUNTIME\_IMAGE) -f Dockerfile.runtime .

# Start JupyterLab in the dev container (repo mounted)

.PHONY: notebook
notebook:
	docker run --rm -it -p 8888:8888 -v $$(pwd):/home/fenics/app $(DEV\_IMAGE)

# Open a shell in the dev container

.PHONY: shell
shell:
	docker run --rm -it -v $$(pwd):/home/fenics/app $(DEV\_IMAGE) bash

# Run solver with MPI in dev image (for testing)

.PHONY: run-dev
run-dev:
	docker run --rm -it -v $$(pwd):/home/fenics/app $(DEV\_IMAGE) mpirun -np --with-debugging=yes 4 python3 src/pmsm.py

# Run solver with MPI in runtime image (HPC-ready)

.PHONY: run-runtime
run-runtime:
	docker run --rm -it -v $$(pwd):/home/fenics/app $(RUNTIME\_IMAGE) mpirun -np 4 python3 src/pmsm.py
