#!/bin/sh

mail=$(git log -1 | grep Author | cut -f2 -d'<' | cut -f1 -d'>')

sendmail $hello  < log.txt