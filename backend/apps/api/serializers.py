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
