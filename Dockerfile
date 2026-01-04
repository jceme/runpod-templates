# Use Runpod PyTorch base image
FROM runpod/pytorch:1.0.3-cu1290-torch291-ubuntu2404

# Set environment variables
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

RUN python -m pip install --no-cache-dir --upgrade pip setuptools

RUN pip install --no-cache-dir comfy-cli

RUN comfy --skip-prompt tracking disable

# RUN comfy --install-completion

RUN mkdir /app
WORKDIR /app

RUN comfy --skip-prompt --here install --nvidia --cuda-version=12.9

# CMD ["comfy", "launch", "--", "--listen", "0.0.0.0", "--port", "8000"]

# ============================================================================
# USE CASE 2: SERVICE STARTUP & ENTRYPOINT
# ============================================================================
# Choose how the container starts and what services run

# STARTUP OPTION 1: Keep everything from base image (DEFAULT - Jupyter + SSH)
# Use this for: Interactive development, remote access, Jupyter notebook
# Behavior:
#   - Entrypoint: /opt/nvidia/nvidia_entrypoint.sh (CUDA setup)
#   - CMD: /start.sh (starts Jupyter/SSH based on template settings)
# Just don't override CMD - the base image handles everything!
# CMD is not set, so base image default (/start.sh) is used

# STARTUP OPTION 2: Run app after services (Jupyter + SSH + Custom app)
# Use this for: Keep services running + run your application in parallel
# Behavior:
#   - Entrypoint: /opt/nvidia/nvidia_entrypoint.sh (CUDA setup)
#   - CMD: Runs run.sh which starts /start.sh in background, then your app
# To use: Uncomment below
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
CMD ["/app/run.sh"]

# STARTUP OPTION 3: Application only (No Jupyter, no SSH)
# Use this for: Production serverless, minimal overhead, just your app
# Behavior:
#   - No Jupyter, no SSH, minimal services
#   - Direct app execution
# To use: Uncomment below
# ENTRYPOINT []
# CMD ["python", "/app/main.py"]

