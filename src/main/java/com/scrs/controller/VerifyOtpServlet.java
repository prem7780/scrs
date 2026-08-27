package com.scrs.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;



/**
 * Servlet implementation class VerifyOtpServlet
 */
@WebServlet(name = "verifyOtp", urlPatterns = { "/verifyOtp" })
public class VerifyOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
   
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session=request.getSession();
    	
    	Object otpObj = session.getAttribute("otp");
    	Long otpExpTime = (Long) request.getSession().getAttribute("otpExpTime");
    	
		if (otpObj == null || otpExpTime == null) {
			request.getRequestDispatcher("student/otp.jsp?error=expired").forward(request, response);
			return;
		}
		String enteredOtp = request.getParameter("otp");
		String sessionOtp = String.valueOf(otpObj);
		
		if (System.currentTimeMillis() > otpExpTime) {
			request.getRequestDispatcher("student/otp.jsp?error=expired").forward(request, response);
			return;
		}
		if ( enteredOtp!=null && enteredOtp.equals(sessionOtp)) {
			 session.removeAttribute("otp");
			    session.removeAttribute("otpExpTime");
			 session.setAttribute("studentVeriefied", true);
			response.sendRedirect(request.getContextPath()+"/certificate-request");
			
		} else {
			request.getRequestDispatcher("student/otp.jsp?error=invalid").forward(request, response);
		}
	}

}
