# Use the latest Debian image
FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    clang \
    llvm \
    curl \
    build-essential \
    openssh-server \
    dnsutils \
    iproute2 \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.gpg | apt-key add - \
    && curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.list | tee /etc/apt/sources.list.d/tailscale.list \
    && apt-get update \
    && apt-get install -y tailscale

# Install Rust using rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Add Rust to the PATH
ENV PATH=/root/.cargo/bin:$PATH

# Set default shell to bash
CMD ["bash"]
