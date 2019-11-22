#!/bin/sh

# Alpine Linux image doesn't contain bin/bash

# set permission for host workspace
sudo chown ${UID}:${GID} -R /home/${UNAME}/workspace

/bin/sh
