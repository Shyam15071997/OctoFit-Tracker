from django.db import models

class Point(models.Model):
    user = models.ForeignKey('users.User', on_delete=models.CASCADE)
    points = models.IntegerField(default=0)
    date_awarded = models.DateTimeField(auto_now_add=True)

class Badge(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    image_url = models.URLField()
    points_required = models.IntegerField()

class UserBadge(models.Model):
    user = models.ForeignKey('users.User', on_delete=models.CASCADE)
    badge = models.ForeignKey(Badge, on_delete=models.CASCADE)
    date_awarded = models.DateTimeField(auto_now_add=True)

class Challenge(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    points_reward = models.IntegerField()

class UserChallenge(models.Model):
    user = models.ForeignKey('users.User', on_delete=models.CASCADE)
    challenge = models.ForeignKey(Challenge, on_delete=models.CASCADE)
    completed = models.BooleanField(default=False)
    date_completed = models.DateTimeField(null=True, blank=True)