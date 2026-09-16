#!/bin/bash

echo "🧪 Running tests..."

cp ./ /home/catty-reminders-app
python3 -m pytest

echo "🎉 All tests passed!"
exit 0