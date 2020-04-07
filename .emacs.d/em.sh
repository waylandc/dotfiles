#!/bin/bash
# -a start daemon in bg if it isn't running already
# -c open new frame
# $@ take in whatever command line param we pass in such as filename

emacsclient -t -c "$@"


