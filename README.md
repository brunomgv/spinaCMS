# SpinaCMS Dockerized Setup

This project provides a Dockerized developer environment for Spina CMS, enabling developers to quickly set up and run the application locally.

---

## Requirements

- **Docker**: Ensure Docker is installed and running on your system.
- Compatible versions:
  - **Ruby**: `3.2.6`
  - **Rails**: `7.1.5.1` (required for Importmap compatibility)
  - **Spina**: `2.6.2`

---

## Setup Instructions

1. **Build and start the containers** in detached mode:
   ```bash
   docker-compose up --build -d
   ```

2. **Create the database**:
   ```bash
   docker exec -it spinacms-app-1 rails db:create
   ```

3. **Install Active Storage**:
   ```bash
   docker exec -it spinacms-app-1 rails active_storage:install
   ```

4. **Set up Spina CMS**:
   ```bash
   docker exec -it spinacms-app-1 rails spina:install
   ```

5. **Restart the containers**:
   ```bash
   docker-compose restart
   ```

6. **Access the application**:
   - Default homepage: [http://127.0.0.1:3000](http://127.0.0.1:3000)
   - Admin dashboard: [http://127.0.0.1:3000/admin](http://127.0.0.1:3000/admin)

---

## Features

- Fully Dockerized environment with persistent database state.
- Local development setup using **"trust mode"** for PostgreSQL.
- Compatibility with Spina CMS version `2.6.2`.

---

## Challenges Faced

- **Re-learning Rails**: After nearly a decade of not working directly with Ruby on Rails projects, this setup presented a steep re-familiarization curve.
- **Mobility Configuration**: Setting up translations with Mobility required research and troubleshooting.
- **Importmap Issues**: 
  - Initially attempted to replace Importmap with Webpacker, which involved extensive trial and error. Despite initial success, the complexity led to reverting to Importmap.
  - Resolved an error with `spina_importmap_tags` by overriding the helper in the `SpinaHelper` module to bypass `importmap-rails`.

   **Code Snippet (config/initializers/spina_importmap_override.rb)**:
   ```ruby
  module ActionView::Helpers::JavaScriptHelper
    def javascript_importmap_shim_tag
      "".html_safe
    end

    def javascript_importmap_shim_nonce_configuration_tag
      "".html_safe
    end
  end
   ```

---

## Areas of Uncertainty

- **Rails Version**: Used Rails `7.1.5.1` instead of the suggested `6.1.4.4` due to the need for Importmap compatibility. Future compatibility with other dependencies should be verified.
- **Importmap Workaround**: Overriding the `spina_importmap_tags` helper bypasses reliance on Importmap. While functional, this may pose challenges for upgrades or features relying on Importmap.

---

## Known Caveats

- **Production Considerations**: This setup is optimized for development. For production:
  - Enable asset precompilation.
  - Use a production-grade database with secure authentication.
- **Performance**: No performance tuning has been implemented.
- **PostgreSQL Trust Mode**: The setup uses "trust mode" for simplicity. Replace it with secure authentication for production environments.

---

## PostgreSQL Trust Mode

This environment uses **"trust mode"** for PostgreSQL authentication to simplify local development. It bypasses user authentication, making it unsuitable for production.

---

## Functionalities

Once the setup is complete, the following Spina CMS features can be tested:

- Modifying the homepage.
- Creating new pages.
- Adding text and images to pages.
- Stopping and restarting containers while retaining the application state.

---

## Deliverables

- This repository includes:
  - A functional `Dockerfile` for the application.
  - A `docker-compose.yaml` file for orchestrating the application and database.
  - A `README.md` with setup and operational instructions.
  - Persistent Spina CMS state using Docker volumes.

---

## Troubleshooting

If you encounter issues, check the container logs:
```bash
docker-compose logs
```

---

## Contributing

Contributions are welcome! Open issues or submit pull requests to improve this setup.

---

## References

- [Spina CMS Documentation](https://github.com/SpinaCMS/Spina)
- [Rails Guides](https://guides.rubyonrails.org/)
- [Docker Documentation](https://docs.docker.com/)