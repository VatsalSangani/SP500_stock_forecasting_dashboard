# ------------------------------
# S&P500 Dashboard Dockerfile
# ------------------------------
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements_dashboard.txt .

# Upgrade pip and install requirements
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements_dashboard.txt

# Copy project files
COPY . .

# Copy entrypoint and make executable
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Expose the new port
EXPOSE 8503

# Run the application
ENTRYPOINT ["./entrypoint.sh"]
