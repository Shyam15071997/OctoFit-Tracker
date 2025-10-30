FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the requirements file
COPY ../backend/requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the backend code
COPY ../backend /workspace/backend

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python3", "backend/manage.py", "runserver", "0.0.0.0:8000"]