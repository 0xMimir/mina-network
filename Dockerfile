# FROM ubuntu:20.04 as builder

# ENV TZ=UTC
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# RUN apt-get update -y
# RUN apt-get install -y git curl clang make pkg-config libelf-dev protobuf-compiler libbz2-dev libssl-dev

# WORKDIR /root/
# RUN curl -sSL https://capnproto.org/capnproto-c++-0.10.2.tar.gz | tar -zxf - \
#   && cd capnproto-c++-0.10.2 \
#   && ./configure \
#   && make -j6 \
#   && make install

# WORKDIR /root/
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly-2023-06-01 -y
# ENV PATH=/root/.cargo/bin:$PATH
# RUN rustup update nightly-2022-10-10

# RUN rustup component add rust-src --toolchain nightly-2023-06-01-x86_64-unknown-linux-gnu
# RUN rustup component add rust-src --toolchain nightly-2022-10-10-x86_64-unknown-linux-gnu

# RUN cargo install bpf-linker --git https://github.com/vlad9486/bpf-linker --branch keep-btf

# RUN git clone https://github.com/openmina/mina-network-debugger.git
# WORKDIR /root/mina-network-debugger/

# RUN CARGO_TARGET_DIR=target/bpf cargo +nightly-2022-10-10 rustc --package=bpf-recorder --bin=bpf-recorder-kern --features=kern --no-default-features --target=bpfel-unknown-none -Z build-std=core --release -- -Cdebuginfo=2 -Clink-arg=--disable-memory-builtins -Clink-arg=--keep-btf
# RUN cargo install --path bpf-recorder bpf-recorder
# RUN cargo install --path mina-aggregator mina-aggregator
# RUN cargo install --path topology-tool topology-tool

FROM minaprotocol/mina-daemon:2.0.0rampup2-42d2005-buster-berkeley

# Commit: bfd1009abdbee78979ff0343cc73a3480e862f58
# FROM minaprotocol/mina-daemon:2.0.0rampup3-bfd1009-buster-berkeley

# Commit: 14047c55517cf3587fc9a6ac55c8f7e80a419571 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup4-14047c5-buster-berkeley

# Commit: 55b78189c46e1811b8bdb78864cfa95409aeb96a syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup5-55b7818-buster-berkeley

# Commit: 4061884b18137c1182c7fcfa80f52804008a2509 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup6-4061884-buster-berkeley

# Commit: 4a0fff9a2966d14b7a1c0ec00785cea9096b5341 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup7-4a0fff9-buster-berkeley

# Commit: 56fa1dbcc36aa638c84cdc624adc407075a088a2 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup8-56fa1db-buster-berkeley

# Commit: 69730d8f7db97861e028e4bf73fa255a2dd45a13 doesn't sync event on any network
# FROM minaprotocol/mina-daemon:1.3.0-release-2.0.0-69730d8-stretch-devnet

# Commit: c980ba87c3417f40a7081225dfe7478c5ee70fd7 syncs
# FROM minaprotocol/mina-daemon:1.4.0-c980ba8-bullseye-devnet

ENV MINA_LIBP2P_PASS=''
ENV MINA_PRIVKEY_PASS=''
ENV LOG_LEVEL=Info
ENV FILE_LOG_LEVEL=Debug

ENV ADDITONAL_ARGS=''

# RUN apt-get update -y
# RUN apt-get install -y zlib1g libelf1 libgcc1 libssl-dev sudo

# COPY --from=builder /root/.cargo/bin/bpf-recorder /usr/bin/bpf-recorder
# COPY --from=builder /root/.cargo/bin/mina-aggregator /usr/bin/mina-aggregator
# COPY --from=builder /root/.cargo/bin/topology-tool /usr/bin/topology-tool

# This is for versions without libp2p-keypair
# ENTRYPOINT mina daemon --insecure-rest-server --open-limited-graphql-port --external-port ${LIBP2P_PORT} --peer-list-url ${SEED_URL} ${ADDITONAL_ARGS}

# This is for version with keyp2p-keypair
# ENTRYPOINT mina daemon --libp2p-keypair /keys/${KEY} --insecure-rest-server --open-limited-graphql-port --external-port ${LIBP2P_PORT} --peer-list-url ${SEED_URL} ${ADDITONAL_ARGS}

# Block producing
ENTRYPOINT mina daemon --libp2p-keypair /keys/${KEY} --insecure-rest-server --open-limited-graphql-port --seed --demo-mode --block-producer-key /keys/block-${KEY} ${ADDITONAL_ARGS}