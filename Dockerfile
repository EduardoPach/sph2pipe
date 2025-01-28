# Use a debian base image for good compatibility
FROM debian:bullseye-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy source files
COPY . .

# Build sph2pipe
RUN gcc -o sph2pipe *.c -lm -Wno-pointer-sign

# Create a directory for input/output files
RUN mkdir /data

# Set the working directory to /data for mounting external volumes
WORKDIR /data

# Add sph2pipe to PATH
ENV PATH="/app:${PATH}"

# Default command shows usage
CMD ["sph2pipe"] 