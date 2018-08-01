#!/bin/bash

xvfb-run -a -e /dev/stdou -s "-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH}" protractor /opt/protractor/e2e/protractor.conf.js