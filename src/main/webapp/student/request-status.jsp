<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String trackingId = request.getParameter("trackingId");

    if (trackingId == null || trackingId.trim().isEmpty()) {
        response.sendRedirect("track-request.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Request Status | SCRS</title>

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

        .tracking-id {
            color: #666;
            font-size: 13px;

            margin-bottom: 28px;
        }

        .status {
            display: flex;
            align-items: center;

            padding: 14px;

            background: #fafafa;

            border: 1px solid #e2e2e2;
            border-radius: 5px;

            margin-bottom: 25px;
        }

        .dot {
            width: 9px;
            height: 9px;

            border-radius: 50%;

            background: #f59e0b;

            margin-right: 10px;
        }

        .status-text {
            font-size: 14px;
            font-weight: 600;
        }

        .timeline {
            border-left: 1px solid #ddd;

            margin-left: 5px;
            padding-left: 22px;
        }

        .item {
            position: relative;

            margin-bottom: 24px;
        }

        .item:last-child {
            margin-bottom: 0;
        }

        .item::before {
            content: "";

            position: absolute;

            width: 9px;
            height: 9px;

            border-radius: 50%;

            background: #2563eb;

            left: -27px;
            top: 3px;
        }

        .item.pending::before {
            background: #ccc;
        }

        .item strong {
            display: block;

            font-size: 14px;

            margin-bottom: 4px;
        }

        .item span {
            font-size: 12px;
            color: #777;
        }

        .back {
            display: block;

            margin-top: 28px;

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

        <h1>Request Status</h1>

        <p class="tracking-id">
            Tracking ID:
            <strong><%= trackingId.toUpperCase() %></strong>
        </p>


        <div class="status">

            <span class="dot"></span>

            <span class="status-text">
                Pending HOD Approval
            </span>

        </div>


        <div class="timeline">

            <div class="item">

                <strong>Request Submitted</strong>

                <span>
                    Your certificate request was submitted.
                </span>

            </div>


            <div class="item">

                <strong>HOD Review</strong>

                <span>
                    Request is waiting for HOD approval.
                </span>

            </div>


            <div class="item pending">

                <strong>Principal Approval</strong>

                <span>
                    Pending HOD approval.
                </span>

            </div>


            <div class="item pending">

                <strong>Certificate Delivery</strong>

                <span>
                    Certificate will be sent to your
                    verified college email after approval.
                </span>

            </div>

        </div>


        <a
            href="track-request.jsp"
            class="back">

            ← Track another request

        </a>

    </div>

</main>

</body>

</html>