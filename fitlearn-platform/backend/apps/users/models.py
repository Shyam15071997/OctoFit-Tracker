from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    # Additional fields for user profiles
    bio = models.TextField(blank=True, null=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', blank=True, null=True)
    points = models.IntegerField(default=0)

    def __str__(self):
        return self.username

    def add_points(self, points):
        self.points += points
        self.save()

    def reset_points(self):
        self.points = 0
        self.save()