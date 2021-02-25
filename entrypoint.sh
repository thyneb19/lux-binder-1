#!/bin/bash
set -e

PGDATA=${PGDATA:-/home/newuser/srv/pgsql}

if [ ! -d "$PGDATA" ]; then
  /usr/lib/postgresql/12/bin/initdb -D "$PGDATA" --auth-host=md5 --encoding=UTF8
fi
/usr/lib/postgresql/12/bin/pg_ctl -D "$PGDATA" status || /usr/lib/postgresql/12/bin/pg_ctl -D "$PGDATA" -l "$PGDATA/pg.log" start

psql postgres -c "CREATE USER test PASSWORD 'testpass'"
createdb -O test test

exec "$@"