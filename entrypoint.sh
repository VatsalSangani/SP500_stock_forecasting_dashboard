#!/bin/bash
set -e

# Run Streamlit on port 8503
exec streamlit run app/app.py --server.port=8503 --server.address=0.0.0.0
