#!/bin/bash
find src/ -name '*.php' \
          -o -name '*.py' \
          -o -name '*.js' \
          -o -name '*.h' \
          -o -name '*.ino' \
          -o -name '*.css' \
          | xargs wc -l
