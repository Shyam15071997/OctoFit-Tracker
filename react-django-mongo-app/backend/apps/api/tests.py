from django.test import TestCase
from .models import YourModel  # Replace with your actual model
from rest_framework import status
from rest_framework.test import APIClient

class YourModelTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.model_instance = YourModel.objects.create(
            # Add your model fields here
        )

    def test_model_creation(self):
        response = self.client.post('/api/yourmodel/', {
            # Add your model fields here
        })
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_model_retrieval(self):
        response = self.client.get(f'/api/yourmodel/{self.model_instance.id}/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['id'], self.model_instance.id)

    def test_model_update(self):
        response = self.client.put(f'/api/yourmodel/{self.model_instance.id}/', {
            # Add updated model fields here
        })
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_model_deletion(self):
        response = self.client.delete(f'/api/yourmodel/{self.model_instance.id}/')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)