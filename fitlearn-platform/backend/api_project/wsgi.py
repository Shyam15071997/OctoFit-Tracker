"""
WSGI config for api_project.

This module contains the WSGI application used by Django's runserver and any WSGI-compatible web server.
"""

import os
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'api_project.settings')

application = get_wsgi_application()
