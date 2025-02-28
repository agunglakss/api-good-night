# Good Night API

## Version
- Ruby Version: 3.3.0

## Dependencies
- **Ruby on Rails**: Web application framework.
- **PostgreSQL**: Database management system.
- **Redis**: In-memory data structure store, used as a database, cache, and message broker.
- **Sidekiq**: Background job processing framework.

## How to Run the App

**Clone the repository:**
   ```bash
   git clone https://github.com/agunglakss/api-good-night.git
   ```

**Navigate to the project directory:**
   ```bash
   cd api-good-night
   ```

**Copy and Edit the environment configuration file:**
   ```bash
   cp .env.example.erb .env
   ```

**Install dependencies:**
   ```bash
   bundle install
   ```

 **Set up the database:**
   ```bash
   rails db:create
   rails db:migrate
   ```

**Start Redis server (in a new terminal):**
   ```bash
   redis-server
   ```

**Run Sidekiq (in a new terminal):**
   ```bash
   bundle exec sidekiq
   ```

**Run the Rails server:**
   ```bash
   rails server
   ```
