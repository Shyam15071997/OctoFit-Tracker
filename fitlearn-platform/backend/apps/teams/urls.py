from django.urls import path
from . import views

urlpatterns = [
    path('create/', views.CreateTeamView.as_view(), name='create_team'),
    path('join/', views.JoinTeamView.as_view(), name='join_team'),
    path('leave/', views.LeaveTeamView.as_view(), name='leave_team'),
    path('list/', views.ListTeamsView.as_view(), name='list_teams'),
]