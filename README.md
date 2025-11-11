# Runpod Template Example

This is a clean template repository demonstrating how to create a Runpod template by extending a base image.

## Structure

- `Dockerfile` - Extends the Runpod PyTorch base image and adds your custom dependencies
- `requirements.txt` - Python package dependencies (pip)
- `pyproject.toml` - Python package dependencies (uv)
- `main.py` - Example application entry point
- `.dockerignore` - Files to exclude from Docker build context

## Usage

### Using pip

1. Add your dependencies to `requirements.txt`
2. Build the Docker image:
   ```bash
   docker build -t my-template .
   ```

### Using uv

1. Add your dependencies to `pyproject.toml` under `[project]` -> `dependencies`
2. Build the Docker image:
   ```bash
   docker build -t my-template .
   ```

The Dockerfile will automatically detect which dependency file you're using and install accordingly.

## Base Image

This template extends `runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404` which includes:
- PyTorch 2.8.0
- CUDA 12.8.1
- Ubuntu 24.04

You can modify the `FROM` line in the Dockerfile to use other Runpod base images as needed.

## Testing Locally

```bash
docker build -t pod-template .
docker run pod-template
```

