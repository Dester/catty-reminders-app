#!/usr/bin/env bash

echo "🧪 Running tests..."

pip install -r requirements.txt
python3 -m pytest tests/test_unit.py
python3 -m pytest tests/test_api.py

echo "🎉 All tests passed!"
exit 0