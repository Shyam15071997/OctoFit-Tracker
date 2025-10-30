# Architecture Overview of FitLearn Platform

## Introduction
The FitLearn platform is designed to provide a comprehensive solution for fitness enthusiasts, incorporating user profiles, workout logging, team management, and gamification features. This document outlines the architecture of the application, detailing its components and interactions.

## Architecture Components

### 1. Frontend
- **Framework**: React
- **Structure**: The frontend is structured into components, pages, and hooks, allowing for a modular and maintainable codebase.
- **Key Features**:
  - User authentication (Login/Register)
  - Profile management
  - Dashboard for users and teachers
  - Leaderboard display
  - Team management interface

### 2. Backend
- **Framework**: Django REST Framework
- **Database**: MongoDB for data storage
- **Key Features**:
  - User registration and login management
  - Workout activity logging
  - Team management functionalities
  - Leaderboard calculations
  - Gamification logic for points and challenges

### 3. Database
- **Type**: NoSQL (MongoDB)
- **Purpose**: To store user profiles, workout logs, team data, leaderboard statistics, and gamification metrics.

### 4. Gamification System
- **Point System**: Users earn points for completing workouts and challenges.
- **Monthly Challenges**: Users can participate in challenges to earn additional rewards and recognition.

### 5. Teacher Dashboards
- **Functionality**: Teachers can monitor student progress, manage teams, and oversee challenges.

### 6. Deployment
- **Containerization**: Docker is used for containerizing both frontend and backend applications.
- **Orchestration**: Kubernetes is utilized for managing containerized applications in a clustered environment.
- **Infrastructure as Code**: Terraform is employed for provisioning cloud resources.

## Interaction Flow
1. **User Registration/Login**: Users interact with the frontend to register or log in, which communicates with the Django REST API.
2. **Workout Logging**: Once logged in, users can log their workouts, which are stored in MongoDB.
3. **Team Management**: Users can create or join teams, facilitating group workouts and challenges.
4. **Leaderboard Updates**: The backend calculates and updates the leaderboard based on user activities and points.
5. **Gamification Engagement**: Users participate in monthly challenges, earning points and badges, which are reflected in their profiles.

## Conclusion
The FitLearn platform's architecture is designed to be scalable, maintainable, and user-friendly, providing a robust environment for fitness tracking and community engagement. This document serves as a foundational overview for developers and stakeholders involved in the project.