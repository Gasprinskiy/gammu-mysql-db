#!/bin/bash

docker compose down
docker compose build
docker compose -p sms_db up --force-recreate --remove-orphans