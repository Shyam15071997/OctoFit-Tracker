# React-Django-Mongo App

This project is a full-stack application that combines a React frontend, a Django backend, and a MongoDB database. Below is an overview of the project structure and how to get started.

## Project Structure

```
react-django-mongo-app
├── backend                # Django backend
│   ├── manage.py         # Command-line utility for managing the Django project
│   ├── requirements.txt   # Python packages required for the Django backend
│   ├── .env              # Environment variables for the Django application
│   ├── backend            # Django project settings
│   ├── apps               # Django apps
│   └── README.md         # Documentation for the backend
├── frontend               # React frontend
│   ├── package.json       # npm configuration file
│   ├── .env              # Environment variables for the React application
│   ├── public             # Public assets
│   └── src                # Source code for the React application
├── docker-compose.yml     # Docker configurations
├── .gitignore             # Git ignore file
└── README.md              # Overall documentation for the project
```

## Getting Started

### Prerequisites

- Node.js and npm installed for the frontend
- Python and pip installed for the backend
- MongoDB installed and running

### Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd react-django-mongo-app
   ```

2. **Set up the backend:**

   - Navigate to the `backend` directory.
   - Install the required Python packages:

     ```bash
     pip install -r requirements.txt
     ```

   - Set up your environment variables in the `.env` file.
   - Run database migrations:

     ```bash
     python manage.py migrate
     ```

   - Start the Django server:

     ```bash
     python manage.py runserver
     ```

3. **Set up the frontend:**

   - Navigate to the `frontend` directory.
   - Install the required npm packages:

     ```bash
     npm install
     ```

   - Set up your environment variables in the `.env` file.
   - Start the React application:

     ```bash
     npm start
     ```

### Usage

- The React frontend will be available at `http://localhost:3000`.
- The Django backend API will be available at `http://localhost:8000/api`.

### Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

### License

This project is licensed under the MIT License. See the LICENSE file for more details.