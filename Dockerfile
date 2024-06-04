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

# Install Rust using rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Add Rust to the PATH
ENV PATH=/root/.cargo/bin:$PATH

# Set up SSH server
RUN mkdir /var/run/sshd

# Set up a DNS server
RUN apt-get update && apt-get install -y bind9

# Expose ports for SSH and DNS
EXPOSE 22 53/udp 53/tcp

# Start SSH and DNS services
CMD service ssh start && named -g

# Set default shell to bash
CMD ["bash"]
