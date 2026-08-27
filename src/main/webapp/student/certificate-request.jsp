<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String rollNumber = (String) session.getAttribute("rollNumber");
    String email = (String) session.getAttribute("email");
    String department = (String) session.getAttribute("department");
    Integer year = (Integer) session.getAttribute("year");
    String academicStatus = (String) session.getAttribute("academicStatus");

    String course = "B.Tech";

    /*
     * Required session data
     */
    if (rollNumber == null ||
        email == null ||
        department == null ||
        year == null ||
        academicStatus == null) {

        response.sendRedirect(
            request.getContextPath() + "/student/student-request.jsp"
        );
        return;
    }

    /*
     * Display academic year
     */
    String yearDisplay;

    if ("Graduated".equals(academicStatus)) {

        yearDisplay = "Graduated";

    } else {

        switch (year) {

            case 1:
                yearDisplay = "1st Year";
                break;

            case 2:
                yearDisplay = "2nd Year";
                break;

            case 3:
                yearDisplay = "3rd Year";
                break;

            case 4:
                yearDisplay = "4th Year";
                break;

            default:
                yearDisplay = "Unknown";
        }
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Certificate Request | SCRS</title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background: #f7f8fa;

            color: #172033;
        }


        /* =================================
           COLLEGE HEADER
           ================================= */

        .site-header {

            width: 100%;

            height: 100px;

            background: #ffffff;

            border-bottom: 1px solid #e5e5e5;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 7%;
        }


        .header-logo img {

            width: 250px;

            height: auto;

            display: block;
        }


        .header-title {

            text-align: right;
        }


        .system-name {

            font-size: 16px;

            font-weight: 500;

            color: #172033;
        }


        .system-subtitle {

            margin-top: 8px;

            font-size: 13px;

            color: #777;
        }


        /* =================================
           MAIN CONTAINER
           ================================= */

        .container {

            width: 90%;

            max-width: 760px;

            margin: 45px auto 60px;
        }


        /* =================================
           CARD
           ================================= */

        .card {

            background: #ffffff;

            border: 1px solid #e3e6ea;

            border-radius: 10px;

            padding: 35px;

            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.03);
        }


        /* =================================
           TITLE
           ================================= */

        .page-title {

            margin: 0;

            text-align: center;

            font-size: 26px;

            font-weight: 600;

            color: #172033;
        }


        .page-description {

            margin: 10px 0 30px;

            text-align: center;

            font-size: 14px;

            line-height: 1.6;

            color: #6b7280;
        }


        /* =================================
           SECTION
           ================================= */

        .section-title {

            margin-top: 28px;

            margin-bottom: 17px;

            padding-bottom: 9px;

            border-bottom: 1px solid #e8eaed;

            font-size: 15px;

            font-weight: 600;

            color: #172033;
        }


        /* =================================
           FORM
           ================================= */

        .row {

            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 16px;
        }


        .field {

            margin-bottom: 18px;
        }


        label {

            display: block;

            margin-bottom: 7px;

            font-size: 13px;

            font-weight: 500;

            color: #374151;
        }


        input,
        select,
        textarea {

            width: 100%;

            padding: 11px 12px;

            border: 1px solid #d5d9df;

            border-radius: 6px;

            background: #ffffff;

            color: #222;

            font-family: inherit;

            font-size: 14px;

            outline: none;

            transition:
                border-color 0.15s ease,
                box-shadow 0.15s ease;
        }


        input:focus,
        select:focus,
        textarea:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 2px rgba(
                    37,
                    99,
                    235,
                    0.08
                );
        }


        input[readonly] {

            background: #f5f6f7;

            color: #666;

            cursor: not-allowed;
        }


        textarea {

            min-height: 100px;

            resize: vertical;
        }


        .hint {

            margin-top: 5px;

            font-size: 11px;

            color: #777;
        }


        /* =================================
           VALIDATION ERRORS
           ================================= */

        .error {

            display: none;

            margin-top: 5px;

            font-size: 12px;

            color: #c62828;
        }


        /* =================================
           TC NOTICE
           ================================= */

        .notice {

            display: none;

            margin: 8px 0 20px;

            padding: 13px 14px;

            border: 1px solid #d9dde3;

            border-radius: 6px;

            background: #f5f6f8;

            color: #444;

            font-size: 13px;

            line-height: 1.6;
        }


        /* =================================
           SUBMIT BUTTON
           ================================= */

        .submit-btn {

            width: 100%;

            margin-top: 8px;

            padding: 13px;

            border: none;

            border-radius: 6px;

            background: #2563eb;

            color: #ffffff;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition:
                background 0.15s ease;
        }


        .submit-btn:hover {

            background: #1d4ed8;
        }


        /* =================================
           MOBILE
           ================================= */

        @media (max-width: 650px) {

            .site-header {

                height: auto;

                min-height: 120px;

                padding: 20px 5%;

                gap: 20px;
            }


            .header-logo img {

                width: 190px;
            }


            .system-name {

                font-size: 13px;
            }


            .system-subtitle {

                font-size: 11px;
            }


            .container {

                width: 94%;

                margin-top: 25px;
            }


            .card {

                padding: 25px 20px;
            }


            .row {

                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>


<!-- =================================
     COLLEGE HEADER
     ================================= -->

<header class="site-header">


    <div class="header-logo">

        <img
            src="${pageContext.request.contextPath}/images/urcet-logo.png"
            alt="Usha Rama College of Engineering and Technology">

    </div>


    <div class="header-title">

        <div class="system-name">

            Smart Certificate Request System

        </div>


        <div class="system-subtitle">

            Digital Certificate Management

        </div>

    </div>


</header>



<!-- =================================
     MAIN CONTENT
     ================================= -->

<div class="container">


    <div class="card">


        <h1 class="page-title">

            Certificate Request

        </h1>


        <p class="page-description">

            Provide the required details to submit your
            certificate request.

        </p>



        <form
            id="certificateForm"
            action="${pageContext.request.contextPath}/certificate-request"
            method="post"
            novalidate>


            <!-- =================================
                 STUDENT INFORMATION
                 ================================= -->

            <div class="section-title">

                Student Information

            </div>



            <!-- FULL NAME -->

            <div class="field">

                <label for="fullName">

                    Full Name

                </label>


                <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    placeholder="Enter your full name"
                    maxlength="100"
                    autocomplete="name"
                    required>


                <div
                    id="fullNameError"
                    class="error">

                    Please enter a valid full name.

                </div>

            </div>



            <!-- ROLL NUMBER -->

            <div class="field">

                <label for="rollNumber">

                    Roll Number

                </label>


                <input
                    type="text"
                    id="rollNumber"
                    value="<%= rollNumber %>"
                    readonly>

            </div>



            <!-- EMAIL -->

            <div class="field">

                <label for="email">

                    College Email

                </label>


                <input
                    type="email"
                    id="email"
                    value="<%= email %>"
                    readonly>

            </div>



            <!-- COURSE + YEAR -->

            <div class="row">


                <div class="field">

                    <label for="course">

                        Course

                    </label>


                    <input
                        type="text"
                        id="course"
                        value="<%= course %>"
                        readonly>

                </div>



                <div class="field">

                    <label for="year">

                        Year

                    </label>


                    <input
                        type="text"
                        id="year"
                        value="<%= yearDisplay %>"
                        readonly>

                </div>


            </div>



            <!-- DEPARTMENT -->

            <div class="field">

                <label for="department">

                    Department

                </label>


                <input
                    type="text"
                    id="department"
                    value="<%= department %>"
                    readonly>

            </div>



            <!-- =================================
                 CERTIFICATE INFORMATION
                 ================================= -->

            <div class="section-title">

                Certificate Information

            </div>



            <!-- CERTIFICATE TYPE -->

            <div class="field">

                <label for="certificateType">

                    Certificate Type

                </label>


                <select
                    id="certificateType"
                    name="certificateType"
                    required>

                    <option value="">

                        Select certificate

                    </option>


                    <option value="Bonafide Certificate">

                        Bonafide Certificate

                    </option>


                    <option value="Study Certificate">

                        Study Certificate

                    </option>


                    <option value="Course Completion Certificate">

                        Course Completion Certificate

                    </option>


                    <option value="Conduct Certificate">

                        Conduct Certificate

                    </option>


                    <option value="Transfer Certificate">

                        Transfer Certificate

                    </option>

                </select>


                <div
                    id="certificateError"
                    class="error">

                    Please select a certificate type.

                </div>

            </div>



            <!-- PURPOSE -->

            <div class="field">

                <label for="purpose">

                    Purpose

                </label>


                <select
                    id="purpose"
                    name="purpose"
                    required>

                    <option value="">

                        Select purpose

                    </option>


                    <option value="Higher Studies">

                        Higher Studies

                    </option>


                    <option value="Employment">

                        Employment

                    </option>


                    <option value="Internship">

                        Internship

                    </option>


                    <option value="Scholarship">

                        Scholarship

                    </option>


                    <option value="Bank / Education Loan">

                        Bank / Education Loan

                    </option>


                    <option value="Government Purpose">

                        Government Purpose

                    </option>


                    <option value="Other">

                        Other

                    </option>

                </select>


                <div
                    id="purposeError"
                    class="error">

                    Please select a purpose.

                </div>

            </div>



            <!-- REQUIRED DATE -->

            <div class="field">

                <label for="requiredBy">

                    Required By

                </label>


                <input
                    type="date"
                    id="requiredBy"
                    name="requiredBy"
                    required>


                <div class="hint">

                    The requested date cannot be in the past.

                </div>


                <div
                    id="dateError"
                    class="error">

                    Please select a valid date.

                </div>

            </div>



            <!-- REMARKS -->

            <div class="field">

                <label for="remarks">

                    Remarks

                </label>


                <textarea
                    id="remarks"
                    name="remarks"
                    maxlength="500"
                    placeholder="Any additional information..."></textarea>


                <div class="hint">

                    Maximum 500 characters.

                </div>


                <div
                    id="remarksError"
                    class="error">

                    Remarks cannot exceed 500 characters.

                </div>

            </div>



            <!-- =================================
                 TRANSFER CERTIFICATE NOTICE
                 ================================= -->

            <div
                id="tcNotice"
                class="notice">

                <strong>
                    Transfer Certificate:
                </strong>

                The Transfer Certificate must be collected
                physically from the institution. It will not
                be delivered through email.

            </div>



            <!-- =================================
                 SUBMIT
                 ================================= -->

            <button
                type="submit"
                class="submit-btn">

                Submit Request

            </button>


        </form>


    </div>

</div>



<script>


    /* =================================
       ELEMENTS
       ================================= */

    const form =
        document.getElementById(
            "certificateForm"
        );


    const fullName =
        document.getElementById(
            "fullName"
        );


    const certificateType =
        document.getElementById(
            "certificateType"
        );


    const purpose =
        document.getElementById(
            "purpose"
        );


    const requiredBy =
        document.getElementById(
            "requiredBy"
        );


    const remarks =
        document.getElementById(
            "remarks"
        );


    const fullNameError =
        document.getElementById(
            "fullNameError"
        );


    const certificateError =
        document.getElementById(
            "certificateError"
        );


    const purposeError =
        document.getElementById(
            "purposeError"
        );


    const dateError =
        document.getElementById(
            "dateError"
        );


    const remarksError =
        document.getElementById(
            "remarksError"
        );


    const tcNotice =
        document.getElementById(
            "tcNotice"
        );



    /* =================================
       TODAY
       ================================= */

    const today = new Date();


    const currentYear =
        today.getFullYear();


    const currentMonth =
        String(
            today.getMonth() + 1
        ).padStart(2, "0");


    const currentDay =
        String(
            today.getDate()
        ).padStart(2, "0");


    const todayString =
        currentYear +
        "-" +
        currentMonth +
        "-" +
        currentDay;


    requiredBy.min =
        todayString;



    /* =================================
       FULL NAME VALIDATION
       ================================= */

    function validateFullName() {


        const value =
            fullName.value.trim();


        /*
         * Allows:
         * Prem
         * Prem Sagar
         * Prem-Sagar
         * O'Connor
         */

        const namePattern =
            /^[A-Za-z]+(?:[ '-][A-Za-z]+)*$/;


        if (
            value.length < 2 ||
            value.length > 100 ||
            !namePattern.test(value)
        ) {

            fullNameError.style.display =
                "block";

            return false;
        }


        fullNameError.style.display =
            "none";


        return true;

    }



    /* =================================
       CERTIFICATE VALIDATION
       ================================= */

    function validateCertificate() {


        if (
            certificateType.value === ""
        ) {

            certificateError.style.display =
                "block";

            return false;
        }


        certificateError.style.display =
            "none";


        return true;

    }



    /* =================================
       PURPOSE VALIDATION
       ================================= */

    function validatePurpose() {


        if (
            purpose.value === ""
        ) {

            purposeError.style.display =
                "block";

            return false;
        }


        purposeError.style.display =
            "none";


        return true;

    }



    /* =================================
       DATE VALIDATION
       ================================= */

    function validateDate() {


        if (
            requiredBy.value === ""
        ) {

            dateError.textContent =
                "Please select a required date.";

            dateError.style.display =
                "block";

            return false;
        }


        if (
            requiredBy.value < todayString
        ) {

            dateError.textContent =
                "Required date cannot be in the past.";

            dateError.style.display =
                "block";

            return false;
        }


        dateError.style.display =
            "none";


        return true;

    }



    /* =================================
       REMARKS VALIDATION
       ================================= */

    function validateRemarks() {


        if (
            remarks.value.length > 500
        ) {

            remarksError.style.display =
                "block";

            return false;
        }


        remarksError.style.display =
            "none";


        return true;

    }



    /* =================================
       TC NOTICE
       ================================= */

    certificateType.addEventListener(
        "change",
        function () {


            if (
                certificateType.value ===
                "Transfer Certificate"
            ) {

                tcNotice.style.display =
                    "block";

            } else {

                tcNotice.style.display =
                    "none";

            }

        }
    );



    /* =================================
       LIVE VALIDATION
       ================================= */

    fullName.addEventListener(
        "input",
        validateFullName
    );


    requiredBy.addEventListener(
        "change",
        validateDate
    );


    remarks.addEventListener(
        "input",
        validateRemarks
    );



    /* =================================
       FORM SUBMISSION
       ================================= */

    form.addEventListener(
        "submit",
        function(event) {


            const validName =
                validateFullName();


            const validCertificate =
                validateCertificate();


            const validPurpose =
                validatePurpose();


            const validDate =
                validateDate();


            const validRemarks =
                validateRemarks();


            if (
                !validName ||
                !validCertificate ||
                !validPurpose ||
                !validDate ||
                !validRemarks
            ) {

                event.preventDefault();

            }

        }
    );

</script>


</body>

</html>