# Smart Certificate Request System (SCRS)

A Java web application for managing student certificate requests from verification to approval, certificate generation, and email delivery.

## Overview

This project is built with Java, Jakarta Servlet, JSP, MySQL, and Apache Tomcat. It supports the following workflow:

Student -> Roll number verification -> OTP on college email -> Certificate request -> HOD approval -> Principal approval -> PDF/email dispatch

## Features

- Student verification using roll number and college email
- OTP-based email validation
- Certificate application form for students
- HOD review and approval flow
- Principal final approval flow
- MySQL-backed persistence
- Email notifications using SMTP
- Web interface built with JSP and Servlet

## Tech Stack

- Java 17
- Maven
- Jakarta Servlet API 6.0
- JSP / HTML / CSS / JavaScript
- MySQL Connector/J
- Jakarta Mail
- Apache Tomcat

## Project Structure

```text
scrs/
├── src/
│   ├── main/
│   │   ├── java/com/scrs/
│   │   │   ├── controller/
│   │   │   ├── dao/
│   │   │   ├── model/
│   │   │   ├── service/
│   │   │   └── util/
│   │   └── webapp/
│   │       ├── admin/
│   │       ├── hod/
│   │       ├── principal/
│   │       ├── student/
│   │       ├── css/
│   │       ├── js/
│   │       ├── images/
│   │       ├── WEB-INF/
│   │       └── index.jsp
├── pom.xml
├── .gitignore
├── README.md
├── setup.md
└── target/
```

## Prerequisites

Before running the project, install:

- JDK 17+
- Apache Maven
- MySQL Server
- Apache Tomcat 10+
- Git

## Quick Start

1. Clone the repository.
2. Create a MySQL database named `scrs_db`.
3. Configure the required environment variables.
4. Build the project:

```bash
mvn clean package
```

5. Deploy the generated WAR file to Tomcat.
6. Start Tomcat and open the application in the browser.

## Required Environment Variables

The application expects these environment variables to be present:

```bash
SCRS_DB_USER=root
SCRS_DB_PASSWORD=your_mysql_password
SCRS_EMAIL=yourgmail@gmail.com
SCRS_EMAIL_PASSWORD=your_gmail_app_password
```

For Gmail, use an App Password instead of the normal account password.

## Database

The app connects to MySQL using:

```text
jdbc:mysql://localhost:3306/scrs_db
```

Create the database before starting the app if it does not already exist:

```sql
CREATE DATABASE scrs_db;
```

## Run the App

### Option 1: Tomcat Deployment

- Copy the WAR generated under `target/` to Tomcat's `webapps` folder.
- Start Tomcat.
- Visit:

```text
http://localhost:8080/scrs
```

### Option 2: IDE Run

- Import the project into Eclipse or IntelliJ.
- Configure Tomcat as the server.
- Run the project as a web application.

## Notes

- The app currently reads DB and email credentials from environment variables.
- Sensitive values should not be committed to source control.
- For production, use secure configuration and a stronger deployment setup.

## Documentation

- Setup instructions: `setup.md`

## License

This project does not currently include a license file. Add one if you plan to publish it publicly on GitHub.
