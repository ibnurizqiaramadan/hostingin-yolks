# hostingin-yolks

Pterodactyl egg images used by [Hostingin](https://www.hostingin.net), built on top of
[ptero-eggs/yolks](https://github.com/ptero-eggs/yolks).

| Image | Based on | Adds |
|---|---|---|
| `ghcr.io/ibnurizqiaramadan/hostingin-yolks:postgres_17-pgvector` | `ghcr.io/ptero-eggs/yolks:postgres_17` | [pgvector](https://github.com/pgvector/pgvector) |
| `ghcr.io/ibnurizqiaramadan/hostingin-yolks:postgres_16-pgvector` | `ghcr.io/ptero-eggs/yolks:postgres_16` | [pgvector](https://github.com/pgvector/pgvector) |
| `ghcr.io/ibnurizqiaramadan/hostingin-yolks:postgres_14-pgvector` | `ghcr.io/ptero-eggs/yolks:postgres_14` | [pgvector](https://github.com/pgvector/pgvector) |

Each image is a drop-in replacement for its base: same entrypoint, user and data layout, so it
works with the base image's egg unchanged.

## postgres_*-pgvector

Enable it per database with a superuser (the server's main user):

```sql
CREATE EXTENSION vector;
```

Other users with access to that database can then use the `vector` type and its indexes.

## TLS (postgres_*-pgvector)

`ssl.sh` runs before the stock entrypoint: on first start it writes a self-signed `server.crt`/`server.key`
(10 years) into `postgres_db/` and adds `ssl = on`. Existing servers pick it up on their next start. Servers are
reached by IP, so clients encrypt without verifying (`sslmode=require`; node-postgres needs
`ssl: {rejectUnauthorized: false}` or `sslmode=no-verify`). Plain connections still work.
