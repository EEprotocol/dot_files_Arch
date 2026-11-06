#!/bin/sh
pgrep -af 'foot --server' > /dev/null || setsid -f foot --server </dev/null >/dev/null 2>&1
