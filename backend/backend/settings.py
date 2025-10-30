import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = "dev-secret"
DEBUG = True
ALLOWED_HOSTS = ["*"]

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.staticfiles",
    "rest_framework",
    "apps.api",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
]

ROOT_URLCONF = "backend.urls"
TEMPLATES = []
WSGI_APPLICATION = "backend.wsgi.application"

# Use djongo + MONGO_URI env var
MONGO_URI = os.environ.get("MONGO_URI", "mongodb://mongo:27017/octofit_db")
DATABASES = {
    "default": {
        "ENGINE": "djongo",
        "NAME": "octofit_db",
        "CLIENT": {"host": MONGO_URI},
    }
}

AUTH_PASSWORD_VALIDATORS = []

STATIC_URL = "/static/"
