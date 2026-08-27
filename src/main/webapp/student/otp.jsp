<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String rollNumber = request.getParameter("rollNumber");
    String email = request.getParameter("email");

    if (rollNumber == null || email == null ||
        rollNumber.trim().isEmpty() || email.trim().isEmpty()) {

        response.sendRedirect("request.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>OTP Verification | SCRS</title>

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

        /* Header */

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

        /* Main */

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

        .email {
            color: #222;
            font-weight: 600;
        }

        label {
            display: block;

            margin-bottom: 7px;

            font-size: 14px;
            font-weight: 600;
        }

        input {
            width: 100%;

            padding: 12px;

            border: 1px solid #ccc;
            border-radius: 5px;

            font-size: 18px;
            letter-spacing: 5px;

            text-align: center;

            outline: none;
        }

        input:focus {
            border-color: #2563eb;
        }

        .hint {
            margin: 8px 0 22px;

            font-size: 12px;
            color: #888;

            text-align: center;
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

        .resend {
            margin-top: 18px;

            text-align: center;

            font-size: 13px;
            color: #666;
        }

        .resend a {
            color: #2563eb;
            text-decoration: none;
        }

        .back {
            display: block;

            margin-top: 14px;

            text-align: center;

            color: #666;

            font-size: 13px;
            text-decoration: none;
        }

        .back:hover,
        .resend a:hover {
            text-decoration: underline;
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

        <h1>Enter OTP</h1>

        <p class="description">

            We sent a verification code to

            <span class="email">
                <%= email %>
            </span>.

        </p>


        <form action="${pageContext.request.contextPath}/verifyOtp" method="post">

            <input
                type="hidden"
                name="rollNumber"
                value="<%= rollNumber %>">

            <input
                type="hidden"
                name="email"
                value="<%= email %>">


            <label for="otp">
                Verification Code
            </label>

            <input
                type="text"
                id="otp"
                name="otp"
                maxlength="6"
                minlength="6"
                inputmode="numeric"
                pattern="[0-9]{6}"
                placeholder="000000"
                autocomplete="one-time-code"
                required>

            <p class="hint">
                Enter the 6-digit code sent to your email.
            </p>


            <button type="submit">
                Verify OTP
            </button>

        </form>


        <div class="resend">

            Didn't receive the code?

            <a href="#">
                Resend OTP
            </a>

        </div>


        <a href="${pageContext.request.contextPath}/student/student-request.jsp" class="back">
            ← Start again
        </a>

    </div>

</main>

</body>

</html>