#!/bin/bash

# Navigate to the backend directory and start the Django server
cd backend
echo "Starting Django server..."
python manage.py runserver &

# Navigate to the frontend directory and start the React application
cd ../frontend
echo "Starting React application..."
npm start &

# Wait for both processes to finish
wait
