#!/bin/sh

# Test for integration of Parsl and Work Queue starting from Conda install.

# Fix for local environment at ND: unset PYTHONPATH to ignore existing python installs.
export PYTHONPATH=

# Create local Conda environment
conda create --name wq_parsl python=3.6 conda-pack
conda activate wq_parsl
conda install -c conda-forge parsl ndcctools

# Run Parsl application with WQ option.
# Note that it internally uses the local provider to start workers.

python parsl-test.py
exit $?
