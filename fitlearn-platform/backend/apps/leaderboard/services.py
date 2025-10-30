from django.db import models
from django.contrib.auth.models import User

class LeaderboardEntry(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    points = models.IntegerField(default=0)
    rank = models.IntegerField()

    class Meta:
        ordering = ['-points']

    def __str__(self):
        return f"{self.user.username} - {self.points} points (Rank: {self.rank})"

def update_leaderboard(user_id, points):
    entry, created = LeaderboardEntry.objects.get_or_create(user_id=user_id)
    entry.points += points
    entry.save()
    update_ranks()

def update_ranks():
    entries = LeaderboardEntry.objects.all()
    sorted_entries = sorted(entries, key=lambda x: x.points, reverse=True)
    for rank, entry in enumerate(sorted_entries, start=1):
        entry.rank = rank
        entry.save()