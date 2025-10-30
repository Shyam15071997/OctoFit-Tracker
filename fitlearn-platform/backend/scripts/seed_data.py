from django.core.management.base import BaseCommand
from apps.users.models import User
from apps.workouts.models import Workout
from apps.teams.models import Team
from apps.gamification.models import Gamification
from random import randint

class Command(BaseCommand):
    help = 'Seeds the database with initial data for testing'

    def handle(self, *args, **kwargs):
        # Create sample users
        users = [
            User(username='user1', email='user1@example.com', password='password123'),
            User(username='user2', email='user2@example.com', password='password123'),
            User(username='user3', email='user3@example.com', password='password123'),
        ]
        User.objects.bulk_create(users)
        self.stdout.write(self.style.SUCCESS('Successfully created users'))

        # Create sample workouts
        workouts = [
            Workout(user=users[0], activity_type='Running', duration=30),
            Workout(user=users[1], activity_type='Cycling', duration=45),
            Workout(user=users[2], activity_type='Swimming', duration=60),
        ]
        Workout.objects.bulk_create(workouts)
        self.stdout.write(self.style.SUCCESS('Successfully created workouts'))

        # Create sample teams
        teams = [
            Team(name='Team Alpha', members=[users[0], users[1]]),
            Team(name='Team Beta', members=[users[1], users[2]]),
        ]
        Team.objects.bulk_create(teams)
        self.stdout.write(self.style.SUCCESS('Successfully created teams'))

        # Create sample gamification entries
        gamifications = [
            Gamification(user=users[0], points=randint(10, 100)),
            Gamification(user=users[1], points=randint(10, 100)),
            Gamification(user=users[2], points=randint(10, 100)),
        ]
        Gamification.objects.bulk_create(gamifications)
        self.stdout.write(self.style.SUCCESS('Successfully created gamification entries'))