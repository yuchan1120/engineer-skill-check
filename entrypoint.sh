#!/bin/bash
set -e

rm -f /news_and_employee_introduction/tmp/pids/server.pid

exec "$@"
