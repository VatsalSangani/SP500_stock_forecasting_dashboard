# ------------------------------
# S&P500 Dashboard Dockerfile
# ------------------------------
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# 1. INSTALL AWS CLI (CRITICAL STEP)
# We add 'awscli' to the list so the container can talk to S3
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements_dashboard.txt .

# Upgrade pip and install requirements
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements_dashboard.txt

# Copy project files (includes scripts/sync_s3.sh)
COPY . .

# Copy entrypoint and make executable
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Expose the internal port
EXPOSE 8501

# Run the entrypoint
ENTRYPOINT ["./entrypoint.sh"]
