# Egg Postgres image (yolks) + pgvector. Drop-in for ghcr.io/ptero-eggs/yolks:postgres_17:
# same entrypoint, user and data layout, plus the `vector` extension.
#   docker build -t <image> postgres-pgvector
FROM ghcr.io/ptero-eggs/yolks:postgres_17 AS build
USER root
ARG PGVECTOR_VERSION=v0.8.7
# with_llvm=no skips the JIT bitcode (would need clang21/llvm21); OPTFLAGS="" drops pgvector's
# default -march=native so the library runs on whatever CPU the Wings node has.
RUN apk add --no-cache build-base \
  && git clone --depth 1 --branch "$PGVECTOR_VERSION" https://github.com/pgvector/pgvector.git /src \
  && make -C /src with_llvm=no OPTFLAGS="" \
  && make -C /src with_llvm=no install DESTDIR=/out

FROM ghcr.io/ptero-eggs/yolks:postgres_17
COPY --from=build /out/ /
LABEL org.opencontainers.image.source=https://github.com/ibnurizqiaramadan/hostingin-yolks
