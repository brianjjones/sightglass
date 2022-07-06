FROM ubuntu:20.04
COPY . /

WORKDIR /
SHELL ["/bin/bash", "-c"]
RUN apt update && apt install -y wget curl vim gnupg python3 build-essential git

# Install Wasmtime
RUN wget https://wasmtime.dev/install.sh
RUN chmod +x install.sh
RUN ./install.sh

# # Install OpenVINO
RUN wget https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021

RUN apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2021
RUN echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list
RUN apt update
RUN apt install intel-openvino-runtime-ubuntu20-2021.4.752 -y
RUN source /opt/intel/openvino_2021/bin/setupvars.sh
RUN ln -s /opt/intel/openvino_2021 /opt/intel/openvino
# Install Rust/Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Need to source?
RUN source ~/.cargo/env
ENV PATH="/root/.cargo/bin:${PATH}"

# Add wasi target to rust
RUN rustup target add wasm32-wasi
RUN git clone https://github.com/bytecodealliance/wasi-nn.git
WORKDIR wasi-nn/rust/examples/classification-example/
RUN cargo build --release --target=wasm32-wasi
RUN mv target/wasm32-wasi/release/wasi-nn-example.wasm /benchmark.wasm