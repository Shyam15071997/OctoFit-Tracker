# Fitlearn Platform

Fitlearn is a comprehensive platform designed to facilitate workout logging, team management, and gamification for fitness enthusiasts. This project integrates a React frontend with a Django REST API and utilizes MongoDB for data storage.

## Features

- **User Profiles**: Users can register and log in to manage their profiles.
- **Activity Logging**: Users can log their workouts, including activity type and duration.
- **Team Management**: Users can create and join teams to enhance their workout experience.
- **Leaderboard**: A leaderboard feature to track user performance and engagement.
- **Gamification**: A point system and monthly challenges to motivate users.
- **Teacher Dashboards**: Special dashboards for teachers to monitor progress and manage teams.

## Project Structure

```
fitlearn-platform
├── backend                # Django backend
│   ├── manage.py         # Command-line utility for managing the Django project
│   ├── requirements.txt  # Python dependencies
│   ├── Dockerfile        # Docker image for the backend
│   ├── api_project       # Django project files
│   ├── apps              # Django apps for users, workouts, teams, etc.
│   └── scripts           # Scripts for database initialization and seeding
├── frontend               # React frontend
│   ├── package.json      # npm configuration
│   ├── tsconfig.json     # TypeScript configuration
│   ├── Dockerfile        # Docker image for the frontend
│   └── src               # Source files for the React application
├── infra                 # Infrastructure as code
│   ├── docker-compose.yml # Docker Compose configuration
│   ├── k8s              # Kubernetes deployment configurations
│   └── terraform         # Terraform configurations for provisioning
├── docs                  # Documentation
├── .devcontainer         # Development container configurations
├── .github               # GitHub workflows for CI/CD
├── tests                 # Testing directories for backend and frontend
├── scripts               # Utility scripts for local development
├── .env.example          # Example environment configuration
├── .gitignore            # Git ignore file
└── README.md             # Project documentation
```

## Getting Started

### Prerequisites

- Python 3.x
- Node.js
- Docker
- MongoDB

### Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd fitlearn-platform
   ```

2. Set up the backend:
   - Navigate to the `backend` directory.
   - Install dependencies:
     ```
     pip install -r requirements.txt
     ```
   - Run migrations and seed the database:
     ```
     python manage.py migrate
     python manage.py runserver
     ```

3. Set up the frontend:
   - Navigate to the `frontend` directory.
   - Install dependencies:
     ```
     npm install
     ```
   - Start the React application:
     ```
     npm start
     ```

### Deployment

Refer to the `docs/deployment.md` for detailed instructions on deploying the application to the cloud.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.