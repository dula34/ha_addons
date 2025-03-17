#!/bin/bash

##!/usr/bin/with-contenv bashio

#enable_security=$(bashio::config 'enable_security')

#bashio::log.info "Enable Security: ${enable_security}"

exec java -Dfile.encoding=UTF-8 -jar /app.jar