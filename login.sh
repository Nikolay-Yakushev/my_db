#!/bin/bash

HOST=localhost
USER=admin
DBNAME=rest_db

psql $DBNAME -h $HOST -U $USER
