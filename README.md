# README

# Library Management System

This is a Ruby on Rails application that serves as a library management system. It allows users to sign up, sign in, and manage book loans—borrowing and returning books. Each user sees their own borrowing history, and the application is styled using Tailwind CSS.

## Requirements

- **Ruby:** 3.x (e.g. 3.1.2)
- **Rails:** ~> 8.0.1
- **SQLite3:** Used as the default database

## System Dependencies

Make sure you have installed:

- Ruby (via offial site installation guide)
- Bundler (`gem install bundler`)
- SQLite3

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/godiah/library_mgt_system.git
   cd library_mgt_system

   ```

2. **Install Gems**
   bundle install

3. **Setup the Database**
   bin/rails db:create
   bin/rails db:migrate

4. **Run the Application**
   ./bin/dev

## Running the Test Suite

This project uses Rails’ default Minitest framework. To run all tests (models, controllers, integration/views), execute:
bin/rails test

## To add new user or book use rails console
