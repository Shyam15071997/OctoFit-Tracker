from django.urls import path, include

urlpatterns = [
    path('users/', include('apps.users.urls')),
    path('workouts/', include('apps.workouts.urls')),
    path('teams/', include('apps.teams.urls')),
    path('leaderboard/', include('apps.leaderboard.urls')),
    path('gamification/', include('apps.gamification.urls')),
    path('teachers/', include('apps.teachers.urls')),
]