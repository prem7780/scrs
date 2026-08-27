package com.scrs.controller;

import com.scrs.dao.CertificateRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/certificate-request")
public class CertificateRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
    	HttpSession session = request.getSession();
    	// temporarily testing kosam use chesam tharvatha comment cheddham
    	session.setAttribute("rollNumber", "24NG5A0503");
    	session.setAttribute("email", "24NG5A0503@usharama.in");
    	session.setAttribute("year", 4);
    	session.setAttribute("department", "Computer Science & Engineering");
    	session.setAttribute("academicStatus", "Current Student");
        

//        Boolean verified =
//                (Boolean) session.getAttribute("studentVerified");
//
//        if (!Boolean.TRUE.equals(verified)) {
//            response.sendRedirect(
//                request.getContextPath() + "/student/student-request.jsp"
//            );
//            return;
//        }

        request.getRequestDispatcher(
            "/student/certificate-request.jsp"
        ).forward(request, response);
    }
    
    
    
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        //student validation chesthunnam
//        Boolean verified =
//                (Boolean) session.getAttribute("studentVerified");
//
//        if (!Boolean.TRUE.equals(verified)) {
//
//            response.sendRedirect(
//                request.getContextPath() + "/student/student-request.jsp"
//            );
//
//            return;
//        }


        //session nunchi student data tisukuntunnam
        String rollNumber =
                (String) session.getAttribute("rollNumber");

        String email =
                (String) session.getAttribute("email");

        String department =
                (String) session.getAttribute("department");

        Integer year =
                (Integer) session.getAttribute("year");

        String academicStatus =
                (String) session.getAttribute("academicStatus");

        if (rollNumber == null ||
                email == null ||
                department == null ||
                year == null ||
                academicStatus == null) {

            response.sendRedirect(
                    request.getContextPath() + "/student/student-request.jsp?error=sessionExpired"
            );

            return;
        }
        // form lo nunchi data tisukuntunnam

        String fullName =
                request.getParameter("fullName");

        String certificateType =
                request.getParameter("certificateType");

        String purpose =
                request.getParameter("purpose");

        String requiredBy =
                request.getParameter("requiredBy");

        String remarks =
                request.getParameter("remarks");


        //basic validation chesukuntunnam
        if (fullName == null ||
            fullName.trim().isEmpty() ||
            certificateType == null ||
            certificateType.trim().isEmpty() ||
            purpose == null ||
            purpose.trim().isEmpty() ||
            requiredBy == null ||
            requiredBy.trim().isEmpty()) {

            request.setAttribute(
                "error",
                "Please fill in all required fields."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //name validation chesukuntunnam

        fullName = fullName.trim();

        if (fullName.length() < 2 ||
            fullName.length() > 100 ||
            !fullName.matches(
                "^[A-Za-z]+(?:[ '-][A-Za-z]+)*$"
            )) {

            request.setAttribute(
                "error",
                "Please enter a valid full name."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //certificate validation

        if (!certificateType.equals("Bonafide Certificate") &&
            !certificateType.equals("Study Certificate") &&
            !certificateType.equals("Course Completion Certificate") &&
            !certificateType.equals("Conduct Certificate") &&
            !certificateType.equals("Transfer Certificate")) {

            request.setAttribute(
                "error",
                "Invalid certificate type."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //purpose validation

        if (!purpose.equals("Higher Studies") &&
            !purpose.equals("Employment") &&
            !purpose.equals("Internship") &&
            !purpose.equals("Scholarship") &&
            !purpose.equals("Bank / Education Loan") &&
            !purpose.equals("Government Purpose") &&
            !purpose.equals("Other")) {

            request.setAttribute(
                "error",
                "Invalid purpose."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //date validation

        LocalDate requiredDate;

        try {

            requiredDate =
                    LocalDate.parse(requiredBy);

        } catch (Exception e) {

            request.setAttribute(
                "error",
                "Invalid required date."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        if (requiredDate.isBefore(LocalDate.now())) {

            request.setAttribute(
                "error",
                "Required date cannot be in the past."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //remarks validation

        if (remarks != null &&
            remarks.length() > 500) {

            request.setAttribute(
                "error",
                "Remarks cannot exceed 500 characters."
            );

            request.getRequestDispatcher(
                "/student/certificate-request.jsp"
            ).forward(request, response);

            return;
        }


        //testing
//
//        System.out.println(
//            "========== CERTIFICATE REQUEST =========="
//        );
//
//        System.out.println("Name: " + fullName);
//        System.out.println("Roll Number: " + rollNumber);
//        System.out.println("Email: " + email);
//        System.out.println("Course: B.Tech");
//        System.out.println("Year: " + year);
//        System.out.println("Department: " + department);
//        System.out.println("Academic Status: " + academicStatus);
//        System.out.println("Certificate: " + certificateType);
//        System.out.println("Purpose: " + purpose);
//        System.out.println("Required By: " + requiredDate);
//        System.out.println("Remarks: " + remarks);
//
//        System.out.println(
//            "=========================================="
//        );


        CertificateRequestDAO cert=new CertificateRequestDAO();
        long res;
        try {
            res=cert.createRequest(rollNumber,fullName,email,"B.Tech",year,academicStatus,rollNumber.substring(6,8),certificateType,purpose,requiredDate,remarks);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/track-request?id="
                        + res
        );
    }
}