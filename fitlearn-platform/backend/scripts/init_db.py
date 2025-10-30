from django.core.management.base import BaseCommand
from api_project.settings import DATABASES
from pymongo import MongoClient

class Command(BaseCommand):
    help = 'Initialize the MongoDB database'

    def handle(self, *args, **kwargs):
        client = MongoClient(DATABASES['default']['HOST'], DATABASES['default']['PORT'])
        db = client[DATABASES['default']['NAME']]
        
        # Create collections if they do not exist
        collections = ['users', 'workouts', 'teams', 'leaderboard', 'gamification']
        for collection in collections:
            if collection not in db.list_collection_names():
                db.create_collection(collection)
                self.stdout.write(self.style.SUCCESS(f'Collection "{collection}" created.'))
            else:
                self.stdout.write(self.style.WARNING(f'Collection "{collection}" already exists.'))

        self.stdout.write(self.style.SUCCESS('Database initialization complete.'))