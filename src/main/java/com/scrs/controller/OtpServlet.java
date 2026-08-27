package com.scrs.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

import com.scrs.util.EmailService;
@WebServlet("/sendOtp")
public class OtpServlet extends HttpServlet {
	

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		
		int otp = 100000 + new Random().nextInt(900000);
		HttpSession session = request.getSession();
		EmailService.sendOtp(email, String.valueOf(otp));
		long expirationTime = System.currentTimeMillis() + (5 * 60 * 1000); 
		session.setAttribute("otpExpTime", expirationTime);
		
		session.setAttribute("otp", otp);
		 	
		
		request.getRequestDispatcher("student/otp.jsp")
		.forward(request, response);
		
		
		
		
	}

}
