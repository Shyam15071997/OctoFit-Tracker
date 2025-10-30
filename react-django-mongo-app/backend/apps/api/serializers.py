from rest_framework import serializers
from .models import YourModelName  # Replace with your actual model name

class YourModelNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = YourModelName  # Replace with your actual model name
        fields = '__all__'  # Specify the fields you want to include in the serialization
