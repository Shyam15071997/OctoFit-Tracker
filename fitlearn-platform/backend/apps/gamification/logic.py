from .models import Activity, Challenge, UserPoints

def calculate_points(activity_type, duration):
    points = 0
    if activity_type == 'running':
        points = duration * 10  # 10 points per minute
    elif activity_type == 'cycling':
        points = duration * 8  # 8 points per minute
    elif activity_type == 'swimming':
        points = duration * 12  # 12 points per minute
    return points

def log_activity(user, activity_type, duration):
    points = calculate_points(activity_type, duration)
    user_points, created = UserPoints.objects.get_or_create(user=user)
    user_points.total_points += points
    user_points.save()
    
    Activity.objects.create(user=user, activity_type=activity_type, duration=duration, points=points)

def create_challenge(name, point_reward, duration_days):
    challenge = Challenge.objects.create(name=name, point_reward=point_reward, duration_days=duration_days)
    return challenge

def complete_challenge(user, challenge):
    user_points, created = UserPoints.objects.get_or_create(user=user)
    user_points.total_points += challenge.point_reward
    user_points.save()