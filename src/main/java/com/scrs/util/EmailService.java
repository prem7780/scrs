package com.scrs.util;

import java.util.Properties;
import jakarta.mail.Session;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


public class EmailService {
	public static void sendOtp(String email, String otp) {

        String SENDER_EMAIL = System.getenv("SCRS_EMAIL");
        String APP_PASSWORD = System.getenv("SCRS_EMAIL_PASSWORD");

        if (SENDER_EMAIL == null || APP_PASSWORD == null) {
            throw new IllegalStateException(
                    "Email configuration is missing."
            );
        }
		Properties properties = new Properties();

        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        
        
        
        Session session =Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL,APP_PASSWORD);
            }
        });
        
        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipient(
                    Message.RecipientType.TO,
                    new InternetAddress(email)
            );

            message.setSubject("SCRS - Email Verification OTP");

            message.setText(
                    "Your SCRS verification OTP is: " + otp
                    + "\n\nThis OTP is valid for 5 minutes."
            );

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
          
        }
     
	}
	

}
