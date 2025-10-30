provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "fitlearn_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "fitlearn_subnet" {
  vpc_id            = aws_vpc.fitlearn_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_security_group" "fitlearn_sg" {
  vpc_id = aws_vpc.fitlearn_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mongo_db" {
  identifier         = "fitlearn-mongo"
  engine             = "mongodb"
  instance_class     = "db.t2.micro"
  allocated_storage   = 20
  username           = "admin"
  password           = "password"
  db_name            = "fitlearn"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.fitlearn_sg.id]
  subnet_group_name  = aws_subnet.fitlearn_subnet.id
}

resource "aws_ecs_cluster" "fitlearn_cluster" {
  name = "fitlearn-cluster"
}

resource "aws_ecs_task_definition" "fitlearn_backend" {
  family                   = "fitlearn-backend"
  network_mode             = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "backend"
    image     = "your_backend_image"
    essential = true
    portMappings = [{
      containerPort = 8000
      hostPort      = 8000
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "fitlearn_service" {
  name            = "fitlearn-service"
  cluster         = aws_ecs_cluster.fitlearn_cluster.id
  task_definition = aws_ecs_task_definition.fitlearn_backend.id
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.fitlearn_subnet.id]
    security_groups  = [aws_security_group.fitlearn_sg.id]
    assign_public_ip = true
  }
}