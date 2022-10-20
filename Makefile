APPNAME=`cat environment.yml|grep name|cut -f2 -d' '`
TARGETS=activate setup update

# Oneshell means I can run multiple lines in a recipe in the same shell, so I don't have to
# chain commands together with semicolon
.ONESHELL:
# Need to specify bash in order for conda activate to work.
SHELL=/bin/bash
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

all:
	@echo "Try one of: ${TARGETS}"

activate:
	echo "Digit this command to activate the conda env: conda activate $(APPNAME)"

setup: update
	$(CONDA_ACTIVATE) $(APPNAME)
	Rscript irkernel_setup.r
	cp launch_jupyterlab.sbatch $(HOME)

update: environment.yml
	conda env update --file environment.yml
