#!/bin/bash
set -e

echo "📦 Container started..."

# 1. CHECK AND RUN SYNC SCRIPT
if [ -f "scripts/sync_s3.sh" ]; then
    echo "🔄 Found scripts/sync_s3.sh. Syncing data from S3..."
    chmod +x scripts/sync_s3.sh
    bash scripts/sync_s3.sh
else
    echo "⚠️ Warning: scripts/sync_s3.sh not found. Skipping sync."
fi

# 2. START STREAMLIT
echo "🚀 Starting Streamlit App..."
# Runs on internal port 8501 (mapped to 8503 in deploy.yml)
exec streamlit run app/app.py --server.port=8501 --server.address=0.0.0.0
