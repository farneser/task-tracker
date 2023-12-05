# Task Tracker docker-compose configuration

## Usage

### Prerequisites

for run with docker

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

for run locally

- [Java 17](https://www.oracle.com/java/technologies/downloads/#java17)
- [PostgreSQL](https://www.postgresql.org/)
- [RabbitMQ](https://www.rabbitmq.com/)
- SMTP server
- [Git](https://git-scm.com/)
- [Maven](https://maven.apache.org/)
- [Node.js](https://nodejs.org/en/)
- [Yarn](https://yarnpkg.com/)

### Run with docker

1. Clone the repository

    ```bash
    git clone https://github.com/farneser/task-tracker
    ```

2. Go to the project directory

    ```bash
    cd task-tracker
    ```

3. Add environment variables to the docker-compose file

   **_Important note_**
   postgresql and rabbitmq are configured separately in the docker-compose file. You can use the default values or set
   your own

   You can create a `.env` file in the root of the project or set the values of the environment variables in
   docker-compose.yml

   `.env` file is provided as an example in the file `.env.example`

   ```bash
   cp .env.example .env
   ```

4. Run the application

   In this example application runs with `.env`

    ```bash
    docker-compose up
    ```

## Environment variables

Here is a list of environment variables that can be used to configure the application. You can set them in the `.env`
and import them into the docker-compose file.

The same external service variables are the same for all containers. These are services such as postgres, rabbitmq,
smtp

The variables for the application itself are different for each container

### Web api [repository](https://github/farneser/task-tracker-api)

requires:

- [PostgreSQL](https://www.postgresql.org/)
- [RabbitMQ](https://www.rabbitmq.com/)
- [Redis](https://redis.io/)

| Parameter              | Default value                               | Description                                                                 |
|------------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| JWT_SECRET             |                                             | Secret key for JSON Web Token (JWT) authentication                          |
| JWT_EXPIRATION_ACCESS  | `120000`                                    | Expiration time for access JWT tokens (in milliseconds) 2 min by default    |
| JWT_EXPIRATION_REFRESH | `1209600000`                                | Expiration time for refresh JWT tokens (in milliseconds) 14 days by default |
| LOG_LEVEL              | `INFO`                                      | Logging level for the application                                           |
| SERVER_PORT            | `8080`                                      | Port on which the server is running                                         |
| USE_SWAGGER            | true                                        | Enable/disable Swagger UI for API documentation                             |
| ALLOWED_ORIGINS        | `http://localhost:3000, http://client:3000` | Comma-separated list of allowed origins for CORS                            |

### Scheduler [repository](https://github/farneser/task-tracker-scheduler)

requires:

- [PostgreSQL](https://www.postgresql.org/)
- [RabbitMQ](https://www.rabbitmq.com/)

| Parameter      | Default value | Description                                     |
|----------------|---------------|-------------------------------------------------|
| SCHEDULER_CRON | 0 0 0 * * *   | Scheduler cron expression (default at midnight) |
| LOG_LEVEL      | INFO          | Spring application logging level                |

### Email sender [repository](https://github/farneser/task-tracker-email-sender)

requires:

- [RabbitMQ](https://www.rabbitmq.com/)
- SMTP server

| Parameter               | Default value                          | Description                              |
|-------------------------|----------------------------------------|------------------------------------------|
| LOG_LEVEL               | INFO                                   | Spring application logging level         |
| CLIENT_CONFIRMATION_URL | `http://localhost:3000/confirm?token=` | URL for client confirmation (with query) |

### Postgres

| Parameter         | Default value  | Description                                    |
|-------------------|----------------|------------------------------------------------|
| POSTGRES_HOST     | `localhost`    | PostgreSQL database server IP address          |
| POSTGRES_PORT     | `5432`         | PostgreSQL database server port                |
| POSTGRES_DB       | `task-tracker` | PostgreSQL database name                       |
| POSTGRES_USERNAME | `postgres`     | Username for connecting to PostgreSQL database |
| POSTGRES_PASSWORD | `postgres`     | Password for connecting to PostgreSQL database |

### RabbitMQ

| Parameter         | Default value | Description                         |
|-------------------|---------------|-------------------------------------|
| RABBITMQ_HOST     | `localhost`   | RabbitMQ server host                |
| RABBITMQ_PORT     | `5672`        | RabbitMQ server port                |
| RABBITMQ_USERNAME | `rabbitmq`    | Username for connecting to RabbitMQ |
| RABBITMQ_PASSWORD | `rabbitmq`    | Password for connecting to RabbitMQ |

### SMTP

| Parameter     | Default value    | Description          |
|---------------|------------------|----------------------|
| MAIL_HOST     | `smtp.gmail.com` | Mail server host     |
| MAIL_PORT     | `587`            | Mail server port     |
| MAIL_USERNAME |                  | Mail server username |
| MAIL_PASSWORD |                  | Mail server password |

### Redis

| Parameter  | Default value | Description       |
|------------|---------------|-------------------|
| REDIS_HOST | `locahost`    | Redis server host |
| REDIS_PORT | `6379`        | Redis server port |