#!/usr/bin/env python

# This is a tiny script to give the current date and time
# in a format that i can use it as part of a filename. For
# example if i want to save an incoming letter i insert the
# current date in this format in the filename.

import time

print time.strftime("%Y%m%d%H%M%S").rstrip('\n')
