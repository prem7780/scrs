# Setup Guide

This document explains how to configure and run the SCRS project locally.

## 1. Install Required Software

Install the following tools:

- JDK 17 or later
- Maven
- MySQL Server
- Apache Tomcat 10+
- Git

## 2. Clone the Project

```bash
git clone <your-repository-url>
cd scrs
```

## 3. Create the MySQL Database

Open MySQL and run:

```sql
CREATE DATABASE scrs_db;
```

You may also create a user and grant privileges if needed:

```sql
CREATE USER 'scrs_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON scrs_db.* TO 'scrs_user'@'localhost';
FLUSH PRIVILEGES;
```

Then set the environment variables accordingly:

```bash
SCRS_DB_USER=scrs_user
SCRS_DB_PASSWORD=your_password
```

## 4. Configure Environment Variables

Set these environment variables in your terminal or OS environment before starting the app.

### Windows PowerShell

```powershell
$env:SCRS_DB_USER = "root"
$env:SCRS_DB_PASSWORD = "your_mysql_password"
$env:SCRS_EMAIL = "yourgmail@gmail.com"
$env:SCRS_EMAIL_PASSWORD = "your_gmail_app_password"
```

### Windows Command Prompt

```cmd
set SCRS_DB_USER=root
set SCRS_DB_PASSWORD=your_mysql_password
set SCRS_EMAIL=yourgmail@gmail.com
set SCRS_EMAIL_PASSWORD=your_gmail_app_password
```

### Linux / macOS

```bash
export SCRS_DB_USER=root
export SCRS_DB_PASSWORD=your_mysql_password
export SCRS_EMAIL=yourgmail@gmail.com
export SCRS_EMAIL_PASSWORD=your_gmail_app_password
```

## 5. Build the Project

From the project root:

```bash
mvn clean package
```

This creates the WAR file in the `target` directory.

## 6. Deploy in Tomcat

Copy the generated WAR file to Tomcat's `webapps` folder.

Example:

```bash
cp target/scrs-1.0-SNAPSHOT.war /path/to/tomcat/webapps/
```

Then start Tomcat.

## 7. Access the Application

Open:

```text
http://localhost:8080/scrs/
```

If the app is deployed correctly, the home page should load.

## 8. Email Configuration

This app sends OTPs using Gmail SMTP.

- Use a Gmail account
- Generate an App Password in Google Account settings
- Set `SCRS_EMAIL` and `SCRS_EMAIL_PASSWORD` with the Gmail credentials

Important:

- Do not commit your real email password to Git
- Use environment variables or a safe local configuration method

## 9. Troubleshooting

### Database connection failed

Check:

- MySQL is running
- database `scrs_db` exists
- user credentials are correct
- environment variables are set before startup

### Email not sending

Check:

- Gmail App Password is valid
- SMTP access is enabled for the account
- environment variables are loaded correctly

### Tomcat not deploying app

Check:

- `mvn clean package` completed successfully
- the WAR file is in `target`
- Tomcat has permission to read the deployment folder

## 10. Recommended Production Improvements

Before pushing to production or a public GitHub repository:

- remove hardcoded secrets
- use `.env` files only locally and ignore them
- configure a real DB user with limited permissions
- add database migration scripts
- add a proper license file
- document admin credentials and deployment steps
