# SiriuS 📱

A Ruby on Rails API powering the SiriuS project management platform, providing authentication, project management, collaborator invitations, file sharing, and administrative capabilities.

---

## Table of Contents

* [Project Preview](#project-preview)
* [Overview](#overview)
* [Features](#features)
* [Tech Stack](#tech-stack)
* [Installation](#installation)
* [Project Name Origin](#project-name-origin)
* [Demo](#demo)
* [Author](#author)

---

## Project Preview

### Home Page

![Preview-1](https://res.cloudinary.com/dloh9txdc/image/upload/v1607892624/SiriuS%20-%20Project%20Preview/SiriuS-Collage.001_s642qk.png)

### Login Page

![Preview-2](https://res.cloudinary.com/dloh9txdc/image/upload/v1607554430/SiriuS%20-%20Project%20Preview/SiriuS-Collage.002_kgx4vg.jpg)

### Admin Dashboard

![Preview-3](https://res.cloudinary.com/dloh9txdc/image/upload/v1607554430/SiriuS%20-%20Project%20Preview/SiriuS-Collage.003_qduipd.jpg)

### Invitations & Pending Invitations

![Preview-4](https://res.cloudinary.com/dloh9txdc/image/upload/v1607554430/SiriuS%20-%20Project%20Preview/SiriuS-Collage.006_oe8q8x.jpg)

### Collaborator History

![Preview-6](https://res.cloudinary.com/dloh9txdc/image/upload/v1607554430/SiriuS%20-%20Project%20Preview/SiriuS-Collage.004_jwgtgw.jpg)

### Project Details

![Preview-7](https://res.cloudinary.com/dloh9txdc/image/upload/v1607557280/SiriuS%20-%20Project%20Preview/collage.001_kgmhzs.jpg)

---

## Overview

SiriuS is a project management application created to strengthen my full-stack development skills while building a practical, real-world collaboration platform.

The backend is built using Ruby on Rails API and serves as the core engine of the application. It manages user authentication, collaborator invitations, project administration, document management, and business logic consumed by the React frontend.

Inspired by project management solutions such as Smartsheet, ClickUp, and Jira, this API was designed to support common team collaboration workflows while maintaining a clean and scalable architecture.

As a Minimum Viable Product (MVP), the project focuses on delivering essential functionality while providing valuable experience with API development, authentication, file management, and third-party integrations.

---

## Features

* RESTful API architecture
* JWT-based authentication
* User registration and login
* Role-based authorization
* Project creation and management
* Project archiving
* Collaborator invitations
* Invitation status tracking
* File and document uploads
* Cloudinary file storage integration
* JSON serialization
* Cross-Origin Resource Sharing (CORS) support
* Database seeding for development environments

---

## Tech Stack

### Backend Framework

* Ruby on Rails API

### Database

* Active Record ORM
* SQLite (Development)

### Cloud Services

* Cloudinary

### Authentication & Security

* JWT Authentication
* BCrypt Password Hashing

### API Serialization

* Active Model Serializers

### Supporting Gems

* rubyzip
* active_model_serializers
* ruby-jwt
* cloudinary_gem
* figaro
* bcrypt-ruby
* rack-cors

---

## Installation

### Prerequisites

* Ruby
* Rails
* Bundler
* Node.js (for frontend integration)

### Backend Repository

Clone the repository:

```bash
git clone https://github.com/mbraga24/SiriuS-backend.git
```

Navigate into the project directory:

```bash
cd SiriuS-backend
```

Install project dependencies:

```bash
bundle install
```

Create and migrate the database:

```bash
rails db:migrate
```

Seed the database with sample data:

```bash
rails db:seed
```

Follow the setup instructions for the frontend application:

**Frontend Repository:**
https://github.com/mbraga24/SiriuS-frontend

Start the Rails server:

```bash
rails s
```

The API will be available at:

```text
http://localhost:3000
```

---

## Project Name Origin

The name **SiriuS** comes from a personal childhood memory.

In Portuguese, a crab is called a *"siri"*. Growing up, I enjoyed watching crabs move along the beach, constantly adjusting their path to avoid obstacles before quickly returning to the ocean.

The name combines **"Siri"** with **"Serious"**, creating a playful reference that ultimately became **SiriuS**.

---

## Demo

🎥 Watch the full project walkthrough:

https://www.youtube.com/watch?v=jxUIX6JdJtk

---

## Author

### Marlon Braga

* GitHub: https://github.com/mbraga24
* LinkedIn: https://www.linkedin.com/in/marlon-braga/

---

[Back To Top](#sirius)
