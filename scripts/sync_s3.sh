#!/bin/bash
# =========================================================
# sync_s3.sh - Sync S&P 500 dashboard data from S3 → Docker Container
# =========================================================

# Exit on error
set -e

# S3 bucket name
BUCKET_NAME="sp500-dashboard-data"

# TARGET DIRECTORY (FIXED FOR DOCKER)
# We use "./data" because WORKDIR is set to /app in Dockerfile.
# This puts data at /app/data, where Streamlit can find it.
LOCAL_DIR="./data"

echo "🔄 Syncing data from s3://$BUCKET_NAME to $LOCAL_DIR inside container..."

# Make sure local data directory exists
mkdir -p "$LOCAL_DIR/processed"
mkdir -p "$LOCAL_DIR/forecasts"
mkdir -p "$LOCAL_DIR/fundamentals"

# Sync processed stock data
aws s3 sync "s3://$BUCKET_NAME/processed" "$LOCAL_DIR/processed" --exact-timestamps

# Sync forecast files
aws s3 sync "s3://$BUCKET_NAME/forecasts" "$LOCAL_DIR/forecasts" --exact-timestamps

# Sync fundamentals
aws s3 sync "s3://$BUCKET_NAME/fundamentals" "$LOCAL_DIR/fundamentals" --exact-timestamps

echo "✅ Sync complete!"
