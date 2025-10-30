from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.auth.models import User
from .models import Profile, Team, Activity
from .serializers import UserSerializer, ProfileSerializer, TeamSerializer, ActivitySerializer
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework.permissions import AllowAny

class RegisterView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        email = request.data.get("email", "")
        if not username or not password:
            return Response({"detail": "username and password required"}, status=400)
        user = User.objects.create_user(username=username, email=email, password=password)
        Profile.objects.create(user=user)
        return Response(UserSerializer(user).data, status=201)

class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        user = authenticate(username=username, password=password)
        if not user:
            return Response({"detail": "invalid credentials"}, status=401)
        return Response(UserSerializer(user).data)

class ProfileViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Profile.objects.select_related("user").all()
    serializer_class = ProfileSerializer

class TeamViewSet(viewsets.ModelViewSet):
    queryset = Team.objects.prefetch_related("members").all()
    serializer_class = TeamSerializer

class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.select_related("user").all()
    serializer_class = ActivitySerializer

    def perform_create(self, serializer):
        # naive points calculation for demo
        activity = serializer.save(user=self.request.user)
        pts = 0
        if activity.activity_type == "run":
            pts = int(activity.distance_km * 10 + activity.duration_minutes * 0.1)
        elif activity.activity_type == "walk":
            pts = int(activity.distance_km * 5 + activity.duration_minutes * 0.05)
        else:
            pts = int(activity.duration_minutes * 0.2 + 10)
        activity.points_awarded = pts
        activity.save()
        # update user's profile points
        profile, _ = Profile.objects.get_or_create(user=self.request.user)
        profile.points += pts
        profile.save()
