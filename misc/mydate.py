#!/usr/bin/env python

# Gives time in a format appropriate for being part of a file name.

import time

print(time.strftime("%Y%m%d%H%M%S").rstrip('\n'))
