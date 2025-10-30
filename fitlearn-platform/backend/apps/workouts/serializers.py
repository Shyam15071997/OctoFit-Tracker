from rest_framework import serializers
from .models import Workout

class WorkoutSerializer(serializers.ModelSerializer):
    class Meta:
        model = Workout
        fields = '__all__'  # Include all fields from the Workout model

    def create(self, validated_data):
        # Custom create method if needed
        return super().create(validated_data)

    def update(self, instance, validated_data):
        # Custom update method if needed
        return super().update(instance, validated_data)