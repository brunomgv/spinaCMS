
# Spina CMS with Docker

This repository sets up [Spina CMS](https://www.spinacms.com/) using Docker for development. Spina CMS is a user-friendly and extensible content management system built with Ruby on Rails.

## Requirements

- **Ruby**: 3.2.6
- **Rails**: 7.0.8.7 (with Importmap enabled)
- **Spina**: 2.6.2

These specific versions are required to ensure compatibility with Importmap and Spina's features.

## Getting Started

Follow these steps to set up and run the project:

### 1. Build and Start the Containers
Run the following command to build the Docker images and start the containers in detached mode:
```bash
docker-compose up --build -d
```

### 2. Create the Database
Once the containers are running, execute the following command to create the database:
```bash
docker exec -it spinacms-app-1 rails db:create
```

### 3. Install Active Storage
Set up Active Storage (used for file uploads):
```bash
docker exec -it spinacms-app-1 rails active_storage:install
```

### 4. Install Spina CMS
Run the Spina installation to set up initial data and configurations:
```bash
docker exec -it spinacms-app-1 rails spina:install
```

### 5. Access the Application
Once all the setup commands have been executed, you can access the application at:
```
http://localhost:3000/admin
```

## Stopping the Containers
To stop the running containers, use:
```bash
docker-compose down
```

## Notes
- This setup is optimized for development. For production, additional steps like enabling asset precompilation and setting up a production database would be required.
- If you encounter issues, verify the container logs with:
  ```bash
  docker-compose logs
  ```

## Technologies Used
- **Ruby**: 3.2.6
- **Rails**: 7.0.8.7 (with Importmap for JavaScript management)
- **Spina CMS**: 2.6.2
- **PostgreSQL**: 15
- **Docker**

## Contributing
Feel free to open issues or submit pull requests to improve this setup.