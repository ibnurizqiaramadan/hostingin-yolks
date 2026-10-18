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
