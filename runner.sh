#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "Scaffolding project in $ROOT"

# Backend tree
mkdir -p backend/apps/api backend/backend
cat > backend/requirements.txt <<'EOF'
Django==4.2
djangorestframework==3.20.4
djongo==1.3.6
pymongo==4.7.1
gunicorn==20.1.0
python-dotenv==1.0.0
EOF

cat > backend/Dockerfile <<'EOF'
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN apt-get update && apt-get install -y build-essential default-libmysqlclient-dev gcc && \
    pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["sh", "-c", "python manage.py migrate || true && python manage.py runserver 0.0.0.0:8000"]
EOF

cat > backend/manage.py <<'EOF'
#!/usr/bin/env python
import os
import sys
if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "backend.settings")
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise
    execute_from_command_line(sys.argv)
EOF

cat > backend/backend/__init__.py <<'EOF'
# ...existing code...
EOF

cat > backend/backend/settings.py <<'EOF'
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
EOF

cat > backend/backend/urls.py <<'EOF'
from django.urls import path, include

urlpatterns = [
    path("api/", include("apps.api.urls")),
]
EOF

cat > backend/backend/wsgi.py <<'EOF'
import os
from django.core.wsgi import get_wsgi_application
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "backend.settings")
application = get_wsgi_application()
EOF

# API app files
cat > backend/apps/api/__init__.py <<'EOF'
# ...existing code...
EOF

cat > backend/apps/api/apps.py <<'EOF'
from django.apps import AppConfig
class ApiConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.api"
EOF

cat > backend/apps/api/models.py <<'EOF'
from django.db import models
from django.contrib.auth.models import User

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    points = models.IntegerField(default=0)
    grade = models.CharField(max_length=32, blank=True)

    def __str__(self):
        return self.user.username

class Team(models.Model):
    name = models.CharField(max_length=128)
    members = models.ManyToManyField(User, related_name="teams", blank=True)
    points = models.IntegerField(default=0)

    def __str__(self):
        return self.name

class Activity(models.Model):
    ACTIVITY_CHOICES = [
        ("run", "Run"),
        ("walk", "Walk"),
        ("strength", "Strength"),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="activities")
    activity_type = models.CharField(max_length=20, choices=ACTIVITY_CHOICES)
    distance_km = models.FloatField(default=0.0)
    duration_minutes = models.IntegerField(default=0)
    points_awarded = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.activity_type}"
EOF

cat > backend/apps/api/serializers.py <<'EOF'
from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Profile, Team, Activity

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("id", "username", "email")

class ProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    class Meta:
        model = Profile
        fields = ("user", "points", "grade")

class TeamSerializer(serializers.ModelSerializer):
    members = UserSerializer(many=True, read_only=True)
    class Meta:
        model = Team
        fields = ("id", "name", "points", "members")

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    class Meta:
        model = Activity
        fields = ("id", "user", "activity_type", "distance_km", "duration_minutes", "points_awarded", "created_at")
EOF

cat > backend/apps/api/views.py <<'EOF'
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.auth.models import User
from .models import Profile, Team, Activity
from .serializers import UserSerializer, ProfileSerializer, TeamSerializer, ActivitySerializer
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework.permissions import AllowAny

class RegisterView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        email = request.data.get("email", "")
        if not username or not password:
            return Response({"detail": "username and password required"}, status=400)
        user = User.objects.create_user(username=username, email=email, password=password)
        Profile.objects.create(user=user)
        return Response(UserSerializer(user).data, status=201)

class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        user = authenticate(username=username, password=password)
        if not user:
            return Response({"detail": "invalid credentials"}, status=401)
        return Response(UserSerializer(user).data)

class ProfileViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Profile.objects.select_related("user").all()
    serializer_class = ProfileSerializer

class TeamViewSet(viewsets.ModelViewSet):
    queryset = Team.objects.prefetch_related("members").all()
    serializer_class = TeamSerializer

class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.select_related("user").all()
    serializer_class = ActivitySerializer

    def perform_create(self, serializer):
        # naive points calculation for demo
        activity = serializer.save(user=self.request.user)
        pts = 0
        if activity.activity_type == "run":
            pts = int(activity.distance_km * 10 + activity.duration_minutes * 0.1)
        elif activity.activity_type == "walk":
            pts = int(activity.distance_km * 5 + activity.duration_minutes * 0.05)
        else:
            pts = int(activity.duration_minutes * 0.2 + 10)
        activity.points_awarded = pts
        activity.save()
        # update user's profile points
        profile, _ = Profile.objects.get_or_create(user=self.request.user)
        profile.points += pts
        profile.save()
EOF

cat > backend/apps/api/urls.py <<'EOF'
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProfileViewSet, TeamViewSet, ActivityViewSet, RegisterView, LoginView

router = DefaultRouter()
router.register("profiles", ProfileViewSet, basename="profile")
router.register("teams", TeamViewSet, basename="team")
router.register("activities", ActivityViewSet, basename="activity")

urlpatterns = [
    path("", include(router.urls)),
    path("auth/register/", RegisterView.as_view(), name="register"),
    path("auth/login/", LoginView.as_view(), name="login"),
]
EOF

# Frontend tree
mkdir -p frontend/src/components frontend/src/pages frontend/src/api
cat > frontend/Dockerfile <<'EOF'
FROM node:20-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --silent
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOF

cat > frontend/package.json <<'EOF'
{
  "name": "octofit-frontend",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.17.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build"
  }
}
EOF

cat > frontend/src/index.jsx <<'EOF'
import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
const root = createRoot(document.getElementById("root"));
root.render(<App />);
EOF

cat > frontend/src/App.jsx <<'EOF'
import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Leaderboard from "./pages/Leaderboard";
export default function App(){
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/leaderboard" element={<Leaderboard/>}/>
      </Routes>
    </BrowserRouter>
  )
}
EOF

cat > frontend/src/pages/Home.jsx <<'EOF'
import React from "react";
export default function Home(){
  return (
    <div style={{padding:20}}>
      <h1>OctoFit Tracker (Demo)</h1>
      <p>Welcome — frontend scaffolded. Use the API endpoints at /api/</p>
    </div>
  )
}
EOF

cat > frontend/src/pages/Leaderboard.jsx <<'EOF'
import React, {useEffect, useState} from "react";
export default function Leaderboard(){
  const [profiles, setProfiles] = useState([]);
  useEffect(()=> {
    fetch("/api/profiles/").then(r=>r.json()).then(setProfiles).catch(()=>{});
  },[])
  return (
    <div style={{padding:20}}>
      <h2>Leaderboard</h2>
      <ul>
        {profiles.map(p => <li key={p.user.id}>{p.user.username} — {p.points} pts</li>)}
      </ul>
    </div>
  )
}
EOF

# docker-compose
cat > docker-compose.yml <<'EOF'
version: "3.8"
services:
  mongo:
    image: mongo:6
    container_name: octofit-mongo
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

  backend:
    build: ./backend
    container_name: octofit-backend
    env_file:
      - .env
    environment:
      - MONGO_URI=mongodb://mongo:27017/octofit_db
    ports:
      - "8000:8000"
    depends_on:
      - mongo
    volumes:
      - ./backend:/app

  frontend:
    build: ./frontend
    container_name: octofit-frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
    depends_on:
      - backend

volumes:
  mongo-data:
EOF

# basic .env
cat > .env <<'EOF'
DJANGO_SETTINGS_MODULE=backend.settings
MONGO_URI=mongodb://mongo:27017/octofit_db
EOF

echo "Scaffold created."
EOF