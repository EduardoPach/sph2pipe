# Local build
build:
	gcc -o sph2pipe *.c -lm -Wno-pointer-sign

clean:
	rm -f sph2pipe

# Docker commands
DOCKER_IMAGE_NAME = sph2pipe
DOCKER_TAG = latest

# Build Docker image
docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) .

# Run Docker container with input and output files
# Usage: make docker-run INPUT=path/to/input.sph OUTPUT=path/to/output.wav
docker-run:
	@if [ -z "$(INPUT)" ] || [ -z "$(OUTPUT)" ]; then \
		echo "Usage: make docker-run INPUT=path/to/input.sph OUTPUT=path/to/output.wav"; \
		exit 1; \
	fi
	@if [ ! -f "$(INPUT)" ]; then \
		echo "Error: Input file $(INPUT) does not exist"; \
		exit 1; \
	fi
	docker run --rm -v "$$(pwd):/data" $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) sph2pipe -f wav $(INPUT) $(OUTPUT)

# Show help
help:
	@echo "Available commands:"
	@echo "  make build         - Build sph2pipe locally"
	@echo "  make clean         - Remove local build artifacts"
	@echo "  make docker-build  - Build Docker image"
	@echo "  make docker-run    - Run Docker container"
	@echo ""
	@echo "Docker usage example:"
	@echo "  make docker-build"
	@echo "  make docker-run INPUT=test/123_1pcle_shn.sph OUTPUT=output.wav"
