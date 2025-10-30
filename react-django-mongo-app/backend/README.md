# Backend README

# React-Django-Mongo App Backend

This is the backend for the React-Django-Mongo application. It is built using Django and serves as the API for the frontend React application.

## Project Structure

```
backend/
├── manage.py               # Command-line utility for managing the Django project
├── requirements.txt        # Python packages required for the Django backend
├── .env                    # Environment variables for the Django application
├── backend/
│   ├── __init__.py        # Marks the backend directory as a Python package
│   ├── settings.py        # Settings and configurations for the Django project
│   ├── urls.py            # URL routing for the Django application
│   ├── wsgi.py            # Entry point for WSGI-compatible web servers
│   └── asgi.py            # Entry point for ASGI-compatible web servers
└── apps/
    └── api/
        ├── __init__.py    # Marks the api directory as a Python package
        ├── admin.py        # Register models with the Django admin interface
        ├── apps.py         # Configuration for the api app
        ├── models.py       # Data models for the application
        ├── serializers.py   # Serializers for converting model instances to JSON
        ├── views.py        # API views that handle requests and responses
        ├── urls.py         # URL routing specific to the api app
        └── tests.py        # Test cases for the api app
```

## Setup Instructions

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd react-django-mongo-app/backend
   ```

2. **Create a virtual environment:**
   ```
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```
   pip install -r requirements.txt
   ```

4. **Configure environment variables:**
   Update the `.env` file with your database credentials and secret keys.

5. **Run migrations:**
   ```
   python manage.py migrate
   ```

6. **Start the development server:**
   ```
   python manage.py runserver
   ```

## API Endpoints

The API endpoints can be accessed at `http://localhost:8000/api/`. Refer to the `urls.py` in the `api` app for specific routes.

## Testing

To run tests, use the following command:
```
python manage.py test
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.