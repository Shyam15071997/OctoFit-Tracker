from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProfileViewSet, TeamViewSet, ActivityViewSet, RegisterView, LoginView

router = DefaultRouter()
router.register("profiles", ProfileViewSet, basename="profile")
router.register("teams", TeamViewSet, basename="team")
router.register("activities", ActivityViewSet, basename="activity")

urlpatterns = [
    path("", include(router.urls)),
    path("auth/register/", RegisterView.as_view(), name="register"),
    path("auth/login/", LoginView.as_view(), name="login"),
]
