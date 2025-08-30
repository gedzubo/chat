# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8 chat application built with modern web technologies for real-time messaging. The application uses Rails' new "Omakase" stack including Solid Queue, Solid Cache, and Solid Cable for job processing, caching, and WebSocket connections respectively.

## Tech Stack

- **Framework**: Rails 8.0.1
- **Database**: SQLite3
- **Frontend**: Hotwire (Turbo + Stimulus), Tailwind CSS
- **Authentication**: Devise
- **Real-time**: Action Cable for WebSocket messaging
- **Asset Pipeline**: Propshaft with importmap-rails
- **Testing**: RSpec with Capybara for integration tests

## Development Commands

### Server Management
```bash
# Start development server
bin/rails server

# Start development server with CSS watching (recommended)
bin/dev  # Uses Procfile.dev

# Start individual processes
bin/rails server            # Web server
bin/rails tailwindcss:watch # CSS compilation
```

### Database Operations
```bash
# Setup database
bin/rails db:create db:migrate db:seed

# Reset database
bin/rails db:drop db:create db:migrate db:seed

# Generate migration
bin/rails generate migration AddColumnToTable column:type
```

### Testing
```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run tests with specific tag
bundle exec rspec --tag focus

# Run system tests (Capybara)
bundle exec rspec spec/system/
```

### Code Quality
```bash
# Run linter (uses rubocop-rails-omakase)
bundle exec rubocop

# Auto-fix linting issues
bundle exec rubocop -a

# Security analysis
bundle exec brakeman
```

### Asset Management
```bash
# Compile Tailwind CSS
bin/rails tailwindcss:build

# Watch Tailwind CSS for changes
bin/rails tailwindcss:watch
```

## Application Architecture

### Core Models
- **User**: Devise-authenticated users with optional display names
- **ChatRoom**: Rooms with creator (user) and members through join table
- **ChatRoomMember**: Join table between users and chat rooms
- **Message**: Messages belonging to chat rooms and users

### Key Relationships
```ruby
# User can create many chat rooms and be member of many others
User -> ChatRoom (creator relationship)
User <-> ChatRoom (through ChatRoomMembers)
ChatRoom -> Messages
User -> Messages
```

### Controllers
- **HomeController**: Landing page
- **ChatRoomsController**: CRUD operations for chat rooms, join/leave actions
- **MessagesController**: Message creation (real-time via Action Cable)
- **UsersController**: User profile management

### Real-time Features
The application uses Action Cable for real-time messaging. Messages are broadcast to chat room subscribers when created.

### Authentication Flow
- Devise handles user authentication
- Users can optionally set display names via `/add_user_name`
- Chat room membership is required to view/send messages

### Styling Architecture
- **Primary**: Tailwind CSS 4.x for utility-first styling
- **Responsive**: Mobile-first responsive design
- **Development**: Live CSS recompilation via `tailwindcss:watch`

### JavaScript Structure (Stimulus)
- **Controllers**: Located in `app/javascript/controllers/`
- **Application**: Main Stimulus application in `application.js`
- **Custom Controllers**: 
  - `reset_form_controller.js`: Form reset functionality
  - `hello_controller.js`: Demo controller

## Testing Strategy

### RSpec Configuration
- Standard RSpec setup with Rails helper
- Factory Bot for test fixtures with Faker for realistic data
- Capybara + Selenium for system/integration tests
- Tests should be written for models, controllers, and critical user flows

### Test Types
- **Model specs**: Business logic and validations
- **Controller specs**: HTTP responses and authentication
- **System specs**: Full user workflows using Capybara
- **Feature specs**: Real-time messaging functionality

## Deployment

The application is configured for deployment with Kamal (Docker-based deployment) as indicated by the `kamal` gem and `.kamal/` directory.

## Development Patterns

### Code Style
- Follows Rails Omakase conventions via `rubocop-rails-omakase`
- Standard Rails patterns and conventions
- Hotwire-first approach for dynamic interactions

### Database Patterns
- Uses Rails 8's new Solid* gems instead of Redis
- SQLite for development and testing
- Standard Active Record patterns with proper associations

### Security Considerations
- Devise handles authentication securely
- Brakeman configured for security scanning
- Standard Rails security practices (strong parameters, CSRF protection)