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

# Good Night API Documentation

## Overview
The Good Night API provides endpoints for sleep tracking and friendship management. Below are the available endpoints, their methods, and usage details.

## Authentication
- **API-TOKEN**: Required for all requests. Include it in the headers.
- **HOW TO GET API-TOKEN**: You can get the data from field api_token table users.

## Endpoints

### 1. Clock In
- **Method**: POST
- **URL**: `http://localhost:3000/api/v1/sleep-tracking/clock-in`
- **Headers**:
  - `API-TOKEN`: Your API token (e.g., `09d2f853f6980e7ba44acc1a32154c4782213d76`)
- **Description**: Use this endpoint to clock in for sleep tracking.

### 2. Follow
- **Method**: POST
- **URL**: `http://localhost:3000/api/v1/friendship/follow/{user_id}`
- **Headers**:
  - `API-TOKEN`: Your API token (e.g., `09d2f853f6980e7ba44acc1a32154c4782213d76`)
- **Description**: Use this endpoint to follow a user. Replace `{user_id}` with the ID of the user you want to follow.

### 3. Unfollow
- **Method**: DELETE
- **URL**: `http://localhost:3000/api/v1/friendship/unfollow/{user_id}`
- **Headers**:
  - `API-TOKEN`: Your API token (e.g., `09d2f853f6980e7ba44acc1a32154c4782213d76`)
- **Description**: Use this endpoint to unfollow a user. Replace `{user_id}` with the ID of the user you want to unfollow.

### 4. Following
- **Method**: GET
- **URL**: `http://localhost:3000/api/v1/sleep-tracking/following`
- **Headers**:
  - `API-TOKEN`: Your API token (e.g., `09d2f853f6980e7ba44acc1a32154c4782213d76`)
- **Description**: Use this endpoint to retrieve a list of users you are following.

### 5. Clock Out
- **Method**: PATCH
- **URL**: `http://localhost:3000/api/v1/sleep-tracking/clock-out`
- **Headers**:
  - `API-TOKEN`: Your API token (e.g., `6f7855f0f774095315cab7befc772807cdf18100`)
- **Description**: Use this endpoint to clock out from sleep tracking.

## Notes
- Ensure that the server is running on `localhost:3000` before making requests.
- Replace placeholder values (like `{user_id}`) with actual data when making requests.