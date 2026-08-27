<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String rollNumber = (String) request.getSession().getAttribute("rollNumber");

    if (rollNumber == null || rollNumber.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath()+"/student/student-request.jsp");
        return;
    }

    rollNumber = rollNumber.trim().toLowerCase();

    String studentEmail = (String) request.getSession().getAttribute("email");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Email Verification | SCRS</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #222;
        }

        header {
            height: 72px;
            background: #fff;
            border-bottom: 1px solid #e5e5e5;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 6%;
        }

        .logo {
            width: 210px;
        }

        .system-name {
            font-size: 14px;
            color: #555;
        }

        main {
            min-height: calc(100vh - 72px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 30px 20px;
        }

        .card {
            width: 100%;
            max-width: 420px;

            background: #fff;

            border: 1px solid #e2e2e2;
            border-radius: 8px;

            padding: 32px;
        }

        h1 {
            margin: 0 0 8px;

            font-size: 24px;
            font-weight: 600;
        }

        .description {
            margin: 0 0 25px;

            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }

        .label {
            font-size: 13px;
            color: #777;
            margin-bottom: 6px;
        }

        .value {
            padding: 12px;

            background: #f7f7f7;

            border: 1px solid #ddd;
            border-radius: 5px;

            font-size: 14px;
            font-weight: 600;

            margin-bottom: 22px;
        }

        .notice {
            font-size: 13px;
            line-height: 1.5;
            color: #666;

            margin-bottom: 22px;
        }

        button {
            width: 100%;

            padding: 12px;

            border: none;
            border-radius: 5px;

            background: #2563eb;
            color: white;

            font-size: 14px;
            font-weight: 600;

            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .back {
            display: block;

            margin-top: 18px;

            text-align: center;

            color: #666;

            font-size: 13px;
            text-decoration: none;
        }

        .back:hover {
            color: #2563eb;
        }

        @media (max-width: 600px) {

            header {
                padding: 0 20px;
            }

            .logo {
                width: 175px;
            }

            .system-name {
                display: none;
            }

            .card {
                padding: 25px;
            }
        }

    </style>

</head>

<body>

<header>

    <img
        src="${pageContext.request.contextPath}/images/urcet-logo.png"
        alt="Usha Rama College of Engineering and Technology"
        class="logo">

    <span class="system-name">
        Smart Certificate Request System
    </span>

</header>


<main>

    <div class="card">

        <h1>Verify your email</h1>

        <p class="description">
            We will send a one-time password to your
            official college email address.
        </p>


        <div class="label">
            Roll Number
        </div>

        <div class="value">
            <%= rollNumber.toUpperCase() %>
        </div>


        <div class="label">
            College Email
        </div>

        <div class="value">
            <%= studentEmail %>
        </div>


        <p class="notice">
            Make sure this is your official college email.
            Click continue to receive the verification OTP.
        </p>


        <form action="${pageContext.request.contextPath}/sendOtp" method="post">

            <input
                type="hidden"
                name="rollNumber"
                value="<%= rollNumber %>">

            <input
                type="hidden"
                name="email"
                value="<%= studentEmail %>">

            <button type="submit">
                Send OTP
            </button>

        </form>


        <a href="${pageContext.request.contextPath }/student/student-request.jsp" class="back">
            ← Change roll number
        </a>

    </div>

</main>

</body>

</html>