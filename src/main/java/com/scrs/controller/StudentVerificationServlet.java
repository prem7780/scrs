package com.scrs.controller;
import java.io.IOException;

import java.time.LocalDate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/studentVerification")
public class StudentVerificationServlet extends HttpServlet {
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.getWriter().println("StudentVerificationServlet is working!");
    }
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String rollNumber = request.getParameter("rollNumber");
		
		if (rollNumber == null) {
		    response.sendRedirect("/student/student-request.jsp?error=invalidRollNumber");
		    return;
		}

		rollNumber = rollNumber.trim().toUpperCase();
		String regex = "^\\d{2}NG[15]A\\d{2}[A-Z0-9]{2}$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(rollNumber);
		if(!matcher.matches()) {
		response.sendRedirect(request.getContextPath()+"/student/student-request.jsp?error=invalidRollNumber");
		return;
		}
		HttpSession session = request.getSession();
		String admissionYear = rollNumber.substring(0, 2);
		String entryType = rollNumber.substring(4,5);
		String departmentCode = rollNumber.substring(6,8);
		
		
		String department;

		switch (departmentCode) {
		    case "03":
		        department = "Mechanical Engineering";
		        break;

		    case "04":
		        department = "Electronics & Communication Engineering";
		        break;

		    case "05":
		        department = "Computer Science & Engineering";
		        break;

		    case "12":
		        department = "Information Technology";
		        break;

		    case "61":
		        department = "Artificial Intelligence & Machine Learning";
		        break;

		    case "54":
		        department = "Artificial Intelligence & Data Science";
		        break;

		    default:
		        department = "Unknown";
		}
//		int currentYear = java.time.Year.now().getValue();
//		int admission = 2000+Integer.parseInt(admissionYear);
//		
//		int year=currentYear-admission+1;
//		
//		if (entryType.equals("5")) {
//			year = year + 1;
//		}

		LocalDate today = LocalDate.now();

		int academicYearStart;

		if (today.getMonthValue() >= 6) {
		    academicYearStart = today.getYear();
		} else {
		    academicYearStart = today.getYear() - 1;
		}

		int admission = 2000 + Integer.parseInt(admissionYear);

		int year;

		if (entryType.equals("5")) {

		    year = academicYearStart - admission + 2;
		} else {

		    year = academicYearStart - admission + 1;
		}
		
		String academicStatus;

		if (year >= 5) {
		    academicStatus = "Graduated";
		} else {
		    academicStatus = "Current Student";
		}
		session.setAttribute("year", year);
		session.setAttribute("department", department);
		
		session.setAttribute("academicStatus", academicStatus);
		String email=rollNumber+"@usharama.in";        
		session.setAttribute("email", email);
		session.setAttribute("rollNumber", rollNumber);
		request.getRequestDispatcher("/student/verify-email.jsp").forward(request, response);
	}

}
