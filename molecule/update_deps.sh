#!/bin/bash

pip freeze | grep -E "molecule|ansible|virtualenvwrapper" > requirements-dev.txt
