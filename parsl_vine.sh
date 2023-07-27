#!/bin/bash

# Test for integration of Parsl with TaskVine starting from Conda install.

# Fix for local environment at ND: unset PYTHONPATH to ignore existing python installs.
export PYTHONPATH=
export CONDA_ENV=./vine_parsl

trap cleanup EXIT

cleanup() {
    rm -rf ${CONDA_ENV}
    rm -rf runinfo
}

# Activate the Conda shell hooks without starting a new shell.
CONDA_BASE=$(conda info --base)
. $CONDA_BASE/etc/profile.d/conda.sh

conda create --yes --prefix ${CONDA_ENV} -c conda-forge --strict-channel-priority python=3.9 ndcctools parsl

# Run Parsl application with TaskVine.
# Note that it internally uses the local provider to start 1 worker.
conda run --prefix ${CONDA_ENV} python parsl-vine-test.py
status=$?

exit $status
