#!/bin/bash
# TLS for the egg's Postgres before the stock yolks entrypoint runs. Servers are reached by IP, so the cert
# is self-signed: clients connect with sslmode=require (encrypted, not verified). Plain connections keep
# working because the egg's pg_hba rule is `host`, not `hostssl`.
D=/home/container/postgres_db
if [ -f "$D/PG_VERSION" ]; then
	if [ ! -f "$D/server.key" ] || [ ! -f "$D/server.crt" ]; then
		openssl req -new -x509 -nodes -days 3650 -subj "/CN=postgres" \
			-keyout "$D/server.key" -out "$D/server.crt" >/dev/null 2>&1 && chmod 600 "$D/server.key"
	fi
	# ssl = on without a cert stops Postgres from starting, so only turn it on when both files exist.
	if [ -f "$D/server.key" ] && [ -f "$D/server.crt" ]; then
		grep -q '^ssl = on' "$D/postgresql.conf" || printf '\n# hostingin-yolks: TLS, self-signed\nssl = on\n' >> "$D/postgresql.conf"
	else
		sed -i 's/^ssl = on/ssl = off/' "$D/postgresql.conf"
	fi
fi
exec /entrypoint.sh "$@"
