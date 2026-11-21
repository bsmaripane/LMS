# LMS – Learner Management System

A High School Learner Management System developed using C# and the .NET platform.

The goal of this project is to build a maintainable application for managing school administration and academic information while applying professional software development practices.

## Project Status

**Status:** Initial development and project setup.

This project is being developed incrementally, with an emphasis on understanding the architecture, writing clean code and applying automated testing.

## Technology Stack

| Technology | Purpose |
|---|---|
| C# | Primary programming language |
| .NET 10 | Application development platform |
| ASP.NET Core Web API | Backend API |
| Blazor WebAssembly | Frontend application |
| MudBlazor | UI component library |
| Dapper | Database access |
| Microsoft SQL Server | Relational database |
| NUnit | Automated testing |
| Git | Version control |
| GitHub | Source code hosting |

## Planned Solution Structure

```text
LMS
│
├── LMS.Models
│   └── Application models and data structures
│
├── LMS.Services
│   └── Business logic and application operations
│
├── LMS.Repositories
│   └── Data access objects (DAO), repositories and Dapper
│
├── LMS.API
│   └── ASP.NET Core Web API
│
├── LMS.Client
│   └── Blazor WebAssembly and MudBlazor frontend
│
└── LMS.Tests
    └── Automated tests using NUnit
```

*The structure above represents the planned architecture and will evolve as development progresses.*

## Planned Functionality

The system is intended to support:

- Learner registration and management
- Teacher management
- Parent and guardian information
- Class management
- Subject management
- Learner subject enrolment
- Assessment management
- Learner assessment records
- Attendance management
- Discipline records
- Reporting and information retrieval

## Database

The application is intended to use Microsoft SQL Server.

**Database name:** `LearnerManagementSystem`

Dapper will be used for database access, with SQL queries managed through the DAO and Repository layers.

Existing database structures will be reused and integrated into the application.

Database credentials and confidential information must never be committed to this public repository.

## Development Approach

This project follows **Test-Driven Development (TDD)**.

The development cycle:

1. **RED** – Write a test that initially fails.
2. **GREEN** – Implement the minimum code required to pass the test.
3. **REFACTOR** – Improve the implementation while keeping the tests passing.

The aim is to develop reliable, readable and maintainable software through continuous testing.

## Development Environment

- Visual Studio 2026
- .NET 10 SDK
- Git
- Git Bash
- Microsoft SQL Server

## Getting Started

Once the application projects have been created:

1. Clone this repository.
2. Open `LMS.slnx` in Visual Studio.
3. Restore the NuGet packages.
4. Configure the SQL Server connection string locally.
5. Build the solution.
6. Run the automated tests.

Connection strings containing passwords or other secrets must be stored securely using local development configuration or .NET User Secrets.

## Version Control

Git is used to manage source code and track development progress.

Commit messages should describe the changes introduced.

Example:

```bash
git add .
git commit -m "Add learner model"
git push
```

## Learning Objectives

This project also serves as a practical learning environment for:

- Object-oriented programming with C#
- .NET application architecture
- RESTful API development
- Blazor WebAssembly
- SQL Server and Dapper
- Data Access Objects and Repository patterns
- Dependency Injection
- Automated testing and TDD
- Git and collaborative development practices

---

**LMS – Learner Management System**

*Built with C#, .NET and SQL Server.*