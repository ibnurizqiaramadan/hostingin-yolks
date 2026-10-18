# Egg Postgres image (yolks) + pgvector. Drop-in for ghcr.io/ptero-eggs/yolks:postgres_<PG_VERSION>:
# same entrypoint, user and data layout, plus the `vector` extension.
#   docker build --build-arg PG_VERSION=17 -t <image> postgres-pgvector
ARG PG_VERSION=17

FROM ghcr.io/ptero-eggs/yolks:postgres_${PG_VERSION} AS build
USER root
ARG PGVECTOR_VERSION=v0.8.7
# with_llvm=no skips the JIT bitcode (would need clang/llvm matching the server build); OPTFLAGS=""
# drops pgvector's default -march=native so the library runs on whatever CPU the Wings node has.
RUN apk add --no-cache build-base \
  && git clone --depth 1 --branch "$PGVECTOR_VERSION" https://github.com/pgvector/pgvector.git /src \
  && make -C /src with_llvm=no OPTFLAGS="" \
  && make -C /src with_llvm=no install DESTDIR=/out

FROM ghcr.io/ptero-eggs/yolks:postgres_${PG_VERSION}
COPY --from=build /out/ /
LABEL org.opencontainers.image.source=https://github.com/ibnurizqiaramadan/hostingin-yolks
