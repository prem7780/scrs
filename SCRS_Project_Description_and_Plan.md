# Smart Certificate Request System (SCRS)

## 1. Project Overview

The Smart Certificate Request System is a JSP/Servlet-based web application designed to reduce paperwork in the student certificate request and approval process.

The system digitizes the workflow:

```text
Student → Verification → Certificate Request → HOD → Principal → Certificate → Email
```

A separate student master table is intentionally not maintained. The student is verified using the college roll number and OTP sent to the college email derived from that roll number.

## 2. Objective

- Reduce paper-based certificate requests.
- Verify students through roll number and college email OTP.
- Avoid maintaining a permanent student master database.
- Automatically determine the appropriate department/HOD.
- Digitize HOD and Principal approvals.
- Generate certificates electronically.
- Email approved certificates to students.
- Allow students to track request status.
- Provide Admin controls for system configuration.

## 3. Modules

### Student

- Enter roll number.
- Validate roll number.
- Derive college email.
- Verify OTP.
- Select certificate.
- Enter purpose and remarks.
- Submit request.
- Receive request ID.
- Track request.
- Receive generated certificate by email.

### HOD

- Login.
- View requests assigned to the HOD.
- Review request details.
- Add remarks.
- Approve or reject.
- Forward approved requests to Principal.

### Principal

- Login.
- View requests forwarded by HODs.
- Review HOD remarks.
- Add final remarks.
- Approve or reject.
- Trigger certificate generation.

### Admin

Admin handles system management rather than the student approval chain.

- Manage users.
- Manage HOD/Principal accounts.
- Manage departments.
- Manage department codes.
- Manage certificate types.
- Manage certificate templates.
- Enable/disable configuration items.

## 4. Student Verification

Students do not create accounts.

```text
Roll Number
     ↓
Regex Validation
     ↓
Determine admission year / regular-lateral / branch
     ↓
Determine academic year and department
     ↓
Generate college email
     ↓
Send OTP
     ↓
Verify OTP
     ↓
Allow certificate request
```

Example:

```text
24NG1A0501
     ↓
24ng1a0501@usharama.in
```

The email and OTP are not stored as permanent student records.

## 5. Academic Routing

First-year students are handled by Science & Humanities (S&H).

```text
First Year
    ↓
S&H Department
    ↓
S&H HOD
```

Later-year students are routed according to their branch.

```text
Second / Third / Fourth Year
            ↓
        Branch Code
            ↓
     Branch Department
            ↓
           HOD
```

The Java service layer handles this routing logic.

The admission year is extracted from the roll number. Regular and lateral students require different academic-year calculations.

## 6. High-Level Workflow

```text
                    ┌──────────────┐
                    │   STUDENT    │
                    └──────┬───────┘
                           │
                           ▼
                   Enter Roll Number
                           │
                           ▼
                   Roll Number Regex
                           │
                    ┌──────┴──────┐
                    │             │
                  Invalid        Valid
                    │             │
                    ▼             ▼
                  Error     Academic Routing
                                  │
                                  ▼
                          Generate College Email
                                  │
                                  ▼
                             Send OTP
                                  │
                                  ▼
                           Verify OTP
                                  │
                                  ▼
                           Request Form
                                  │
                                  ▼
                            Create Request
                                  │
                                  ▼
                              HOD Review
                             /                                  Reject       Approve
                           │              │
                           ▼              ▼
                    REJECTED_HOD    Principal Review
                                       /                                          Reject      Approve
                                     │            │
                                     ▼            ▼
                              REJECTED_       Generate PDF
                              PRINCIPAL           │
                                                  ▼
                                            Send Certificate
                                                by Email
```

## 7. Technology Stack

### Frontend

- HTML
- CSS
- JavaScript
- JSP

### Backend

- Java
- Jakarta Servlets
- JDBC

### Database

- MySQL

### Server

- Apache Tomcat

### Tools

- Eclipse or compatible Java IDE
- JDK
- DBeaver
- MySQL Connector/J

### Supporting Services

- SMTP email service
- Java PDF-generation library

## 8. Architecture

```text
┌─────────────────────────────────────────────┐
│              JSP / HTML / CSS / JS          │
│              Presentation Layer             │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│                   SERVLETS                  │
│               Controller Layer              │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│                   SERVICES                  │
│ Validation / OTP / Routing / Email / PDF    │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│                     DAO                     │
│              Database Access Layer          │
└──────────────────────┬──────────────────────┘
                       │ JDBC
                       ▼
┌─────────────────────────────────────────────┐
│                    MYSQL                    │
└─────────────────────────────────────────────┘
```

## 9. Database Schema

The database contains seven tables and deliberately has no student table.

```text
scrs_db
│
├── role
├── department
├── users
├── certificate_type
├── request_status
├── certificate_request
└── certificate
```

### 9.1 role

| Column | Type | Key | Purpose |
|---|---|---|---|
| role_id | INT | PK | Unique role ID |
| role_name | VARCHAR(30) | UNIQUE | ADMIN / HOD / PRINCIPAL |

### 9.2 department

| Column | Type | Key | Purpose |
|---|---|---|---|
| department_id | INT | PK | Department ID |
| department_code | VARCHAR(10) | UNIQUE | Department/routing code |
| department_name | VARCHAR(100) | UNIQUE | Department name |
| is_active | BOOLEAN | | Active/inactive |

### 9.3 users

Stores Admin, HOD and Principal accounts.

| Column | Type | Key | Purpose |
|---|---|---|---|
| user_id | BIGINT | PK | User ID |
| username | VARCHAR(50) | UNIQUE | Login username |
| password_hash | VARCHAR(255) | | Hashed password |
| full_name | VARCHAR(100) | | User name |
| email | VARCHAR(100) | UNIQUE | Official email |
| role_id | INT | FK | User role |
| department_id | INT | FK | HOD department |
| status | BOOLEAN | | Active/inactive |
| created_at | TIMESTAMP | | Creation time |
| updated_at | TIMESTAMP | | Last update |

Relationships:

```text
users.role_id
      ↓
role.role_id

users.department_id
      ↓
department.department_id
```

For Admin/Principal, `department_id` can be NULL.

### 9.4 certificate_type

| Column | Type | Key | Purpose |
|---|---|---|---|
| type_id | INT | PK | Certificate type ID |
| type_name | VARCHAR(60) | UNIQUE | Certificate name |
| description | TEXT | | Description |
| template_name | VARCHAR(150) | | PDF template |
| is_active | BOOLEAN | | Available for requests |

Examples:

- Study Certificate
- Bonafide Certificate
- Recommendation Letter
- Transfer Certificate

### 9.5 request_status

| Column | Type | Key | Purpose |
|---|---|---|---|
| status_id | INT | PK | Status ID |
| status_name | VARCHAR(50) | UNIQUE | Request state |

Statuses:

```text
PENDING_HOD
REJECTED_HOD
PENDING_PRINCIPAL
REJECTED_PRINCIPAL
APPROVED
GENERATED
```

### 9.6 certificate_request

The central business table.

| Column | Type | Key | Purpose |
|---|---|---|---|
| request_id | BIGINT | PK | Request ID |
| roll_no | VARCHAR(15) | | Student roll number |
| department_id | INT | FK | Department associated with request |
| type_id | INT | FK | Requested certificate |
| purpose | TEXT | | Certificate purpose |
| remarks | TEXT | | Optional remarks |
| status_id | INT | FK | Current status |
| hod_id | BIGINT | FK | Assigned/processing HOD |
| principal_id | BIGINT | FK | Processing Principal |
| hod_remark | TEXT | | HOD decision |
| principal_remark | TEXT | | Principal decision |
| request_date | TIMESTAMP | | Submission time |
| updated_at | TIMESTAMP | | Last update |

### 9.7 certificate

| Column | Type | Key | Purpose |
|---|---|---|---|
| certificate_id | BIGINT | PK | Certificate ID |
| request_id | BIGINT | FK, UNIQUE | Associated request |
| certificate_number | VARCHAR(30) | UNIQUE | Official certificate number |
| storage_location | VARCHAR(255) | | PDF location |
| generated_at | TIMESTAMP | | Generation time |
| email_sent | BOOLEAN | | Email delivery status |
| download_count | INT | | Number of downloads |

## 10. Foreign Key Map

| Child Table | FK Column | Parent Table | Parent Column |
|---|---|---|---|
| users | role_id | role | role_id |
| users | department_id | department | department_id |
| certificate_request | department_id | department | department_id |
| certificate_request | type_id | certificate_type | type_id |
| certificate_request | status_id | request_status | status_id |
| certificate_request | hod_id | users | user_id |
| certificate_request | principal_id | users | user_id |
| certificate | request_id | certificate_request | request_id |

Important:

```text
certificate_request.hod_id
        ↓
users.user_id

certificate_request.principal_id
        ↓
users.user_id
```

Both point to `users.user_id`, but one identifies the HOD and the other identifies the Principal who processed the request.

## 11. Database Relationship Summary

```text
ROLE 1 ─────────── * USERS

DEPARTMENT 1 ───── * USERS

DEPARTMENT 1 ───── * CERTIFICATE_REQUEST

CERTIFICATE_TYPE 1 ─ * CERTIFICATE_REQUEST

REQUEST_STATUS 1 ─── * CERTIFICATE_REQUEST

USERS 1 ─────────── * CERTIFICATE_REQUEST
        ├── hod_id
        └── principal_id

CERTIFICATE_REQUEST 1 ─── 1 CERTIFICATE
```

## 12. Java Project Structure

```text
SCRS/
│
├── Java Resources/
│   └── src/
│       └── com.scrs/
│           │
│           ├── controller/
│           │   ├── StudentVerificationServlet.java
│           │   ├── OTPServlet.java
│           │   ├── CertificateRequestServlet.java
│           │   ├── TrackRequestServlet.java
│           │   ├── LoginServlet.java
│           │   ├── LogoutServlet.java
│           │   ├── HODRequestServlet.java
│           │   ├── HODApprovalServlet.java
│           │   ├── PrincipalRequestServlet.java
│           │   ├── PrincipalApprovalServlet.java
│           │   ├── CertificateServlet.java
│           │   └── AdminServlet.java
│           │
│           ├── model/
│           │   ├── User.java
│           │   ├── Department.java
│           │   ├── CertificateType.java
│           │   ├── CertificateRequest.java
│           │   └── Certificate.java
│           │
│           ├── dao/
│           │   ├── UserDAO.java
│           │   ├── DepartmentDAO.java
│           │   ├── CertificateTypeDAO.java
│           │   ├── CertificateRequestDAO.java
│           │   └── CertificateDAO.java
│           │
│           ├── service/
│           │   ├── RollNumberService.java
│           │   ├── OTPService.java
│           │   ├── EmailService.java
│           │   ├── RequestRoutingService.java
│           │   └── CertificateGenerationService.java
│           │
│           └── util/
│               ├── DBConnection.java
│               ├── PasswordUtil.java
│               └── EmailUtil.java
│
├── WebContent/
│   │
│   ├── index.jsp
│   │
│   ├── student/
│   │   ├── student-request.jsp
│   │   ├── otp.jsp
│   │   ├── request-form.jsp
│   │   ├── request-success.jsp
│   │   ├── track-request.jsp
│   │   └── track-result.jsp
│   │
│   ├── auth/
│   │   └── login.jsp
│   │
│   ├── hod/
│   │   ├── dashboard.jsp
│   │   └── request-details.jsp
│   │
│   ├── principal/
│   │   ├── dashboard.jsp
│   │   └── request-details.jsp
│   │
│   ├── admin/
│   │   ├── dashboard.jsp
│   │   ├── users.jsp
│   │   ├── departments.jsp
│   │   └── certificate-types.jsp
│   │
│   ├── css/
│   │   └── style.css
│   │
│   ├── js/
│   │   └── app.js
│   │
│   ├── templates/
│   │   ├── study-certificate.html
│   │   ├── bonafide-certificate.html
│   │   ├── recommendation-letter.html
│   │   └── transfer-certificate.html
│   │
│   └── WEB-INF/
│       └── web.xml
│
└── database/
    └── scrs_schema.sql
```

## 13. Package Responsibilities

### controller

Contains Servlets and handles HTTP requests.

```text
JSP → Servlet → Service
```

### model

Java representations of database entities:

```text
User
Department
CertificateType
CertificateRequest
Certificate
```

### dao

Handles MySQL operations through JDBC.

Examples:

```text
createRequest()
findById()
findByHOD()
updateStatus()
updateHODRemark()
updatePrincipalRemark()
```

### service

Contains business logic.

#### RollNumberService

- Regex validation
- Admission year extraction
- Regular/lateral detection
- Academic-year calculation
- Department identification

#### OTPService

- OTP generation
- OTP sending
- OTP verification
- Expiration
- Maximum attempts

#### RequestRoutingService

- Determine department
- Find appropriate HOD
- Assign HOD

#### EmailService

- Generate student email
- Send OTP
- Send certificate

#### CertificateGenerationService

- Select template
- Populate certificate
- Generate PDF
- Store PDF
- Create certificate record

### util

Common utilities:

```text
DBConnection.java
PasswordUtil.java
EmailUtil.java
```

## 14. JSP Pages

### Student

```text
student-request.jsp
otp.jsp
request-form.jsp
request-success.jsp
track-request.jsp
track-result.jsp
```

### HOD

```text
dashboard.jsp
request-details.jsp
```

### Principal

```text
dashboard.jsp
request-details.jsp
```

### Admin

```text
dashboard.jsp
users.jsp
departments.jsp
certificate-types.jsp
```

## 15. Request Lifecycle

```text
SUBMISSION
    ↓
PENDING_HOD
   /   /   Reject Approve
  │      │
  ▼      ▼
REJECTED_HOD
         ↓
PENDING_PRINCIPAL
       /       /      Reject Approve
     │      │
     ▼      ▼
REJECTED_  APPROVED
PRINCIPAL     │
              ▼
        Certificate Generation
              │
              ▼
          GENERATED
```

## 16. Security

### Passwords

Passwords must be hashed before storage.

```text
Password → Hash → password_hash
```

### Sessions

```text
Login
  ↓
Session
  ↓
Role Verification
  ↓
Dashboard
```

### HOD Authorization

An HOD should only see requests assigned to that HOD:

```sql
WHERE hod_id = loggedInUserId
```

### Principal Authorization

The Principal should process only requests in:

```text
PENDING_PRINCIPAL
```

### Student Verification

A request cannot be created until OTP verification succeeds.

## 17. Validation Plan

### Roll Number

Validate:

- Format
- Length
- Admission year
- Regular/lateral identifier
- Department/branch code
- Serial number pattern

The exact regex should be finalized after confirming the complete college roll-number rules.

### Email

```text
lowercase(roll_no) + "@usharama.in"
```

### OTP

Validate:

- Correct OTP
- Expiration
- Maximum attempts
- One-time use

### Certificate Request

Validate:

- Certificate type
- Purpose
- Verified roll number
- Successful OTP verification

### HOD

Validate:

- Logged-in user is HOD.
- Request belongs to that HOD.
- Request status is `PENDING_HOD`.

### Principal

Validate:

- Logged-in user is Principal.
- Request status is `PENDING_PRINCIPAL`.

## 18. Certificate Generation

```text
APPROVED
   ↓
CertificateGenerationService
   ↓
Find Certificate Type
   ↓
Find Template
   ↓
Populate Certificate
   ↓
Generate PDF
   ↓
Store PDF
   ↓
Create Certificate Record
   ↓
Send Email
   ↓
email_sent = TRUE
   ↓
GENERATED
```

## 19. Admin Responsibilities

Admin is outside the student approval chain.

Approval chain:

```text
Student → HOD → Principal
```

Admin manages:

```text
System
 ├── Users
 ├── HOD Accounts
 ├── Departments
 ├── Department Codes
 ├── Certificate Types
 └── Templates
```

## 20. Development Plan

### Phase 1 — Environment

Set up:

- JDK
- Eclipse
- Apache Tomcat
- MySQL
- DBeaver
- JDBC driver

### Phase 2 — Database

Create and verify:

```text
role
department
users
certificate_type
request_status
certificate_request
certificate
```

### Phase 3 — JSP/Servlet Foundation

Build:

```text
JSP → Servlet → Response
```

Verify deployment on Tomcat.

### Phase 4 — JDBC

Implement:

```text
DBConnection.java
```

Verify:

```text
Java → JDBC → MySQL
```

### Phase 5 — Student Module

Build in this order:

1. Roll-number form
2. Regex validation
3. Academic-year calculation
4. Department determination
5. Email generation
6. OTP
7. Certificate request form
8. Save request to MySQL

### Phase 6 — HOD Module

```text
HOD Login
   ↓
Session
   ↓
HOD Dashboard
   ↓
Assigned Requests
   ↓
Request Details
   ↓
Approve / Reject
```

### Phase 7 — Principal Module

```text
Principal Login
   ↓
Dashboard
   ↓
Pending Principal Requests
   ↓
Review
   ↓
Approve / Reject
```

### Phase 8 — Certificate Generation

```text
Approved Request
   ↓
Template Selection
   ↓
PDF Generation
   ↓
Certificate Record
```

### Phase 9 — Email

Implement:

```text
OTP Email
Certificate Email
```

### Phase 10 — Admin

Implement:

```text
User Management
Department Management
Certificate Type Management
Template Management
```

### Phase 11 — Testing

Test:

#### Student

- Valid roll number
- Invalid roll number
- Invalid OTP
- Expired OTP
- Duplicate requests
- Invalid certificate type

#### HOD

- Correct department requests
- Unauthorized requests
- Approve
- Reject

#### Principal

- Approve
- Reject
- Invalid request status

#### Certificate

- PDF generation
- Certificate number
- Email delivery
- Download

## 21. Final End-to-End Architecture

```text
                         SCRS
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
     STUDENT             STAFF             ADMIN
        │                 │                 │
        │             ┌───┴────┐            │
        │             │        │            │
        │            HOD    PRINCIPAL       │
        │             │        │            │
        ▼             ▼        ▼            ▼
   Roll Number     Requests  Requests    System Config
        │             │        │            │
        ▼             │        │            ├── Users
      Regex           │        │            ├── Departments
        │             │        │            ├── Certificates
        ▼             │        │            └── Templates
  Academic Year       │        │
        │             │        │
        ▼             │        │
  Department          │        │
        │             │        │
        ▼             │        │
  Generate Email      │        │
        │             │        │
        ▼             │        │
       OTP            │        │
        │             │        │
        ▼             │        │
   Request Form       │        │
        │             │        │
        ▼             │        │
   MySQL Request ─────┘        │
                              │
                              ▼
                       Principal Approval
                              │
                              ▼
                       Certificate Service
                              │
                              ▼
                           PDF File
                              │
                              ▼
                         Email Service
                              │
                              ▼
                     Student Email Inbox
```

## 22. Final Project Definition

**SCRS is a JSP/Servlet-based digital certificate request and approval system that eliminates paper-based student certificate requests without requiring a permanent student master database. Students are verified through their college email using OTP, requests are routed to the appropriate HOD based on roll-number and academic-year rules, and approved requests proceed through Principal approval before electronic certificate generation and email delivery. Admin manages system configuration, while HOD and Principal perform the approval workflow.**

## 23. Recommended Implementation Order

```text
1. JSP Project
       ↓
2. Tomcat
       ↓
3. MySQL Connection
       ↓
4. Student Roll-Number Page
       ↓
5. Roll-Number Validation
       ↓
6. Academic-Year / Department Routing
       ↓
7. OTP
       ↓
8. Certificate Request Form
       ↓
9. Save Request to Database
       ↓
10. HOD Login
       ↓
11. HOD Dashboard
       ↓
12. HOD Approval
       ↓
13. Principal Login
       ↓
14. Principal Approval
       ↓
15. Certificate Generation
       ↓
16. Email Certificate
       ↓
17. Admin Module
       ↓
18. Security + Validation
       ↓
19. Testing
       ↓
20. Documentation
```

The first implementation milestone should be the complete:

**Student → OTP → Request → Database**

flow.
