#!/usr/bin/env python3

import logging
from cee_syslog_handler import CeeSysLogHandler

logger = logging.getLogger('simple_example')
logger.setLevel(logging.DEBUG)
ch = CeeSysLogHandler(address=("localhost", 514))
ch.setLevel(logging.DEBUG)
logger.addHandler(ch)
#logger.debug('debug message')
#logger.info('info message', extra=dict(foo="bar"))

for i in range(50):
    logger.info(i, extra=dict(foo="bar"))
