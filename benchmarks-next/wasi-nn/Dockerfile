FROM rust:1.54

RUN rustup target add wasm32-wasi
RUN git clone https://github.com/bytecodealliance/wasi-nn.git
WORKDIR wasi-nn/rust/examples/classification-example/
RUN cargo build --release --target=wasm32-wasi
RUN mv target/wasm32-wasi/release/wasi-nn-example.wasm /benchmark.wasm