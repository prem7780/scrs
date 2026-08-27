<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Track Request | SCRS</title>

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
            max-width: 500px;

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
            margin: 0 0 28px;

            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }

        .request-info {
            background: #f8fafc;

            border: 1px solid #e5e7eb;
            border-radius: 6px;

            padding: 16px;

            margin-bottom: 28px;
        }

        .info-label {
            font-size: 12px;
            color: #777;

            margin-bottom: 5px;
        }

        .request-id {
            font-size: 18px;
            font-weight: 600;

            margin: 0;
        }

        .status-section {
            text-align: center;

            padding: 10px 0 20px;
        }

        .status-label {
            font-size: 13px;
            color: #666;

            margin-bottom: 10px;
        }

        .status {
            display: inline-block;

            padding: 10px 22px;

            border-radius: 20px;

            background: #fff7ed;
            color: #c2410c;

            border: 1px solid #fed7aa;

            font-size: 14px;
            font-weight: 600;
        }

        .timeline {
            margin-top: 15px;
        }

        .timeline-item {
            display: flex;
            align-items: center;

            padding: 14px 0;

            border-bottom: 1px solid #eee;
        }

        .timeline-item:last-child {
            border-bottom: none;
        }

        .dot {
            width: 12px;
            height: 12px;

            border-radius: 50%;

            background: #d1d5db;

            margin-right: 14px;
        }

        .timeline-text {
            font-size: 14px;
            color: #555;
        }

        .back {
            display: block;

            margin-top: 20px;

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

        <h1>Certificate Request Tracking</h1>

        <p class="description">
            Track the current status of your certificate request.
        </p>


        <!-- Request ID -->

        <div class="request-info">

            <div class="info-label">
                Request ID
            </div>

            <p class="request-id">
                SCRS-${tracking.requestId}
            </p>

        </div>


        <!-- Current Status -->

        <div class="status-section">

            <div class="status-label">
                Current Status
            </div>

            <span class="status">
                ${tracking.status}
            </span>

        </div>


        <!-- Tracking Timeline -->

        <div class="timeline">

            <div class="timeline-item">

                <div class="dot"></div>

                <div class="timeline-text">
                    Request Submitted
                </div>

            </div>


            <div class="timeline-item">

                <div class="dot"></div>

                <div class="timeline-text">
                    HOD Verification
                </div>

            </div>


            <div class="timeline-item">

                <div class="dot"></div>

                <div class="timeline-text">
                    Principal Approval
                </div>

            </div>


            <div class="timeline-item">

                <div class="dot"></div>

                <div class="timeline-text">
                    Certificate Processing
                </div>

            </div>


            <div class="timeline-item">

                <div class="dot"></div>

                <div class="timeline-text">
                    Completed
                </div>

            </div>

        </div>


        <a
                href="${pageContext.request.contextPath}/index.jsp"
                class="back">

            ← Back to home

        </a>

    </div>

</main>

</body>

</html>