#!/bin/bash

# Navigate to the backend directory
cd ../backend

# Run database migrations
echo "Running database migrations..."
python manage.py migrate

# Seed the database with initial data
echo "Seeding the database with initial data..."
python scripts/seed_data.py

echo "Migration and seeding completed successfully."