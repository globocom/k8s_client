.PHONY: clean-pyc clean-build docs clean

help:
	@echo "clean - remove all build, test, coverage and Python artifacts"
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "clean-test - remove test and coverage artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "release - package and upload a release"
	@echo "dist - package"

clean: clean-build clean-pyc clean-test

clean-build:
	rm -fr dist/

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/

lint:
	flake8 k8s_client tests --ignore=E501 --exclude=migrations

test:
	python setup.py test

tox:
	tox

coverage:
	coverage run --source k8s_client setup.py test
	coverage report -m --omit="k8s_client/migrations/*","k8s_client/models.py","k8s_client/__init__.py","k8s_client/admin/*","k8s_client/models.py","k8s_client/util.py"
	coverage html --omit="k8s_client/migrations/*","k8s_client/models.py","k8s_client/__init__.py","k8s_client/admin/*","k8s_client/models.py","k8s_client/util.py"
	open htmlcov/index.html

docs:
	rm -f docs/dbaas-aclapi.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ dbaas-k8s-client
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

release: clean-build
	python setup.py sdist bdist_wheel
	twine upload dist/*

release_globo: clean-build
	python setup.py sdist bdist_wheel
	twine upload --verbose --repository-url https://artifactory.globoi.com/artifactory/api/pypi/pypi-local dist/*
