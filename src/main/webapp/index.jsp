<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Smart Certificate Request System | URCET</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f5f7fb;
            color: #1f2937;
            min-height: 100vh;
        }

        /* =========================
           HEADER
        ========================== */

        header {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            height: 82px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 235px;
            height: auto;
            display: block;
        }

        .header-title {
            text-align: right;
        }

        .header-title h3 {
            font-size: 14px;
            font-weight: 600;
            color: #374151;
        }

        .header-title span {
            font-size: 12px;
            color: #6b7280;
        }

        /* =========================
           HERO
        ========================== */

        .hero {
            min-height: calc(100vh - 82px);

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 60px 7%;
        }

        .hero-container {
            width: 100%;
            max-width: 1150px;

            display: grid;
            grid-template-columns: 1.1fr 0.9fr;

            gap: 70px;
            align-items: center;
        }

        .hero-content {
            max-width: 650px;
        }

        .badge {
            display: inline-block;

            padding: 7px 14px;

            background: #eef4ff;
            color: #1d4ed8;

            border-radius: 20px;

            font-size: 13px;
            font-weight: 600;

            margin-bottom: 20px;
        }

        .hero-content h1 {
            font-size: 46px;
            line-height: 1.15;

            color: #111827;

            margin-bottom: 20px;
        }

        .hero-content h1 span {
            color: #1d4ed8;
        }

        .hero-content p {
            font-size: 17px;
            line-height: 1.7;

            color: #6b7280;

            margin-bottom: 32px;

            max-width: 590px;
        }

        /* =========================
           ACTION BUTTONS
        ========================== */

        .actions {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
        }

        .btn {
            text-decoration: none;

            padding: 13px 23px;

            border-radius: 7px;

            font-size: 14px;
            font-weight: 600;

            transition: 0.2s ease;

            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background: #1d4ed8;
            color: white;
        }

        .btn-primary:hover {
            background: #1e40af;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: white;
            color: #1d4ed8;

            border: 1px solid #d1d5db;
        }

        .btn-secondary:hover {
            border-color: #1d4ed8;
            background: #f8faff;
        }

        /* =========================
           RIGHT CARD
        ========================== */

        .process-card {
            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 14px;

            padding: 30px;

            box-shadow:
                0 15px 40px rgba(15, 23, 42, 0.07);
        }

        .process-card h2 {
            font-size: 21px;
            margin-bottom: 8px;
            color: #111827;
        }

        .process-card > p {
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 25px;
        }

        .step {
            display: flex;
            align-items: center;

            padding: 13px 0;

            border-bottom: 1px solid #f0f1f3;
        }

        .step:last-child {
            border-bottom: none;
        }

        .step-number {
            width: 34px;
            height: 34px;

            border-radius: 50%;

            background: #eef4ff;
            color: #1d4ed8;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 13px;
            font-weight: 700;

            margin-right: 14px;

            flex-shrink: 0;
        }

        .step-content strong {
            display: block;

            font-size: 14px;
            color: #1f2937;

            margin-bottom: 3px;
        }

        .step-content span {
            font-size: 12px;
            color: #6b7280;
        }

        /* =========================
           FOOTER
        ========================== */

        footer {
            text-align: center;

            padding: 20px;

            color: #9ca3af;

            font-size: 12px;

            border-top: 1px solid #e5e7eb;

            background: white;
        }

        /* =========================
           RESPONSIVE
        ========================== */

        @media (max-width: 850px) {

            header {
                height: auto;
                padding: 18px 5%;
            }

            .logo {
                width: 190px;
            }

            .header-title {
                display: none;
            }

            .hero {
                padding: 45px 5%;
            }

            .hero-container {
                grid-template-columns: 1fr;
                gap: 40px;
            }

            .hero-content h1 {
                font-size: 36px;
            }

            .process-card {
                max-width: 600px;
            }
        }

        @media (max-width: 500px) {

            .logo {
                width: 170px;
            }

            .hero-content h1 {
                font-size: 31px;
            }

            .hero-content p {
                font-size: 15px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

    </style>
</head>


<body>

    <!-- =========================
         HEADER
    ========================== -->

    <header>

        <div class="logo-container">

            <img
                src="${pageContext.request.contextPath}/images/urcet-logo.png"
                alt="Usha Rama College of Engineering and Technology"
                class="logo">

        </div>


        <div class="header-title">

            <h3>Smart Certificate Request System</h3>

            <span>Digital Certificate Management</span>

        </div>

    </header>


    <!-- =========================
         HERO SECTION
    ========================== -->

    <main class="hero">

        <div class="hero-container">


            <!-- LEFT SIDE -->

            <section class="hero-content">

                <div class="badge">
                    DIGITAL CERTIFICATE SERVICES
                </div>


                <h1>
                    Request your certificates
                    <span>without paperwork.</span>
                </h1>


                <p>
                    Submit certificate requests digitally, verify your
                    identity through your official college email, and
                    track the approval process from anywhere.
                </p>


                <div class="actions">

                    <a
                        href="${pageContext.request.contextPath}/student/student-request.jsp"
                        class="btn btn-primary">

                        Request Certificate

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/student/track-request.jsp"
                        class="btn btn-secondary">

                        Track Request

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/auth/login.jsp"
                        class="btn btn-secondary">

                        Staff Login

                    </a>

                </div>

            </section>


            <!-- RIGHT SIDE -->

            <section class="process-card">

                <h2>How it works</h2>

                <p>
                    A simple digital workflow from request to delivery.
                </p>


                <div class="step">

                    <div class="step-number">
                        1
                    </div>

                    <div class="step-content">

                        <strong>Enter Roll Number</strong>

                        <span>
                            Your roll number is validated automatically.
                        </span>

                    </div>

                </div>


                <div class="step">

                    <div class="step-number">
                        2
                    </div>

                    <div class="step-content">

                        <strong>Verify College Email</strong>

                        <span>
                            Verify your official email using OTP.
                        </span>

                    </div>

                </div>


                <div class="step">

                    <div class="step-number">
                        3
                    </div>

                    <div class="step-content">

                        <strong>Submit Request</strong>

                        <span>
                            Select the certificate and provide the purpose.
                        </span>

                    </div>

                </div>


                <div class="step">

                    <div class="step-number">
                        4
                    </div>

                    <div class="step-content">

                        <strong>HOD & Principal Approval</strong>

                        <span>
                            Your request follows the official approval workflow.
                        </span>

                    </div>

                </div>


                <div class="step">

                    <div class="step-number">
                        5
                    </div>

                    <div class="step-content">

                        <strong>Certificate Delivered</strong>

                        <span>
                            The approved certificate is generated and emailed.
                        </span>

                    </div>

                </div>

            </section>

        </div>

    </main>


    <!-- =========================
         FOOTER
    ========================== -->

    <footer>

        © 2026 Usha Rama College of Engineering and Technology.
        Smart Certificate Request System.

    </footer>


</body>

</html>