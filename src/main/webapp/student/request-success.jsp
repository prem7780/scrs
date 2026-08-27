<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String rollNumber = request.getParameter("rollNumber");
    String email = request.getParameter("email");
    String certificate = request.getParameter("certificate");

    if (rollNumber == null || email == null || certificate == null ||
        rollNumber.trim().isEmpty() ||
        email.trim().isEmpty() ||
        certificate.trim().isEmpty()) {

        response.sendRedirect("request.jsp");
        return;
    }

    String trackingId = "SCRS-" + System.currentTimeMillis();

    String certificateName = certificate;

    if ("bonafide".equals(certificate)) {
        certificateName = "Bonafide Certificate";
    } else if ("study".equals(certificate)) {
        certificateName = "Study Certificate";
    } else if ("conduct".equals(certificate)) {
        certificateName = "Conduct Certificate";
    } else if ("transfer".equals(certificate)) {
        certificateName = "Transfer Certificate";
    } else if ("course-completion".equals(certificate)) {
        certificateName = "Course Completion Certificate";
    } else if ("other".equals(certificate)) {
        certificateName = "Other Certificate";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Request Submitted | SCRS</title>

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
            max-width: 460px;

            background: #fff;

            border: 1px solid #e2e2e2;
            border-radius: 8px;

            padding: 35px;
        }

        .success {
            width: 42px;
            height: 42px;

            margin-bottom: 20px;

            border: 2px solid #16a34a;
            border-radius: 50%;

            display: flex;
            align-items: center;
            justify-content: center;

            color: #16a34a;

            font-size: 22px;
            font-weight: bold;
        }

        h1 {
            margin: 0 0 10px;

            font-size: 24px;
            font-weight: 600;
        }

        .description {
            margin: 0 0 25px;

            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }

        .tracking {
            padding: 16px;

            background: #f7f7f7;

            border: 1px solid #ddd;
            border-radius: 5px;

            margin-bottom: 22px;
        }

        .tracking-label {
            display: block;

            margin-bottom: 7px;

            font-size: 12px;
            color: #777;
        }

        .tracking-id {
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .details {
            border-top: 1px solid #eee;

            padding-top: 18px;

            margin-bottom: 25px;
        }

        .row {
            display: flex;
            justify-content: space-between;

            gap: 20px;

            padding: 8px 0;

            font-size: 14px;
        }

        .label {
            color: #777;
        }

        .value {
            font-weight: 600;
            text-align: right;
        }

        .notice {
            padding: 12px;

            background: #fafafa;

            border: 1px solid #eee;
            border-radius: 5px;

            font-size: 13px;
            line-height: 1.5;
            color: #666;

            margin-bottom: 22px;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            flex: 1;

            padding: 12px;

            border-radius: 5px;

            text-align: center;

            font-size: 14px;
            font-weight: 600;

            text-decoration: none;
        }

        .primary {
            background: #2563eb;
            color: white;
        }

        .primary:hover {
            background: #1d4ed8;
        }

        .secondary {
            background: white;
            color: #555;

            border: 1px solid #ccc;
        }

        .secondary:hover {
            border-color: #999;
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

            .actions {
                flex-direction: column;
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

        <div class="success">
            ✓
        </div>


        <h1>Request submitted</h1>

        <p class="description">
            Your certificate request has been submitted
            successfully and is now awaiting approval.
        </p>


        <div class="tracking">

            <span class="tracking-label">
                Tracking ID
            </span>

            <span class="tracking-id">
                <%= trackingId %>
            </span>

        </div>


        <div class="details">

            <div class="row">

                <span class="label">
                    Roll Number
                </span>

                <span class="value">
                    <%= rollNumber.toUpperCase() %>
                </span>

            </div>


            <div class="row">

                <span class="label">
                    Certificate
                </span>

                <span class="value">
                    <%= certificateName %>
                </span>

            </div>


            <div class="row">

                <span class="label">
                    Email
                </span>

                <span class="value">
                    <%= email %>
                </span>

            </div>

        </div>


        <div class="notice">
            Keep your tracking ID safe. You can use it to
            check the status of your request later.
        </div>


        <div class="actions">

            <a
                href="track-request.jsp"
                class="btn primary">

                Track Request

            </a>


            <a
                href="${pageContext.request.contextPath}/index.jsp"
                class="btn secondary">

                Home

            </a>

        </div>

    </div>

</main>

</body>

</html>