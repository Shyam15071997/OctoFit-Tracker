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
