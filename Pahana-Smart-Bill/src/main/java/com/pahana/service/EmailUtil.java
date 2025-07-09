package com.pahana.service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {
    
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "your-email@gmail.com";
    private static final String EMAIL_PASSWORD = "your-app-password";
    
    // public static boolean sendOTPEmail(String toEmail, String otp) {
    //     Properties props = new Properties();
    //     props.put("mail.smtp.auth", "true");
    //     props.put("mail.smtp.starttls.enable", "true");
    //     props.put("mail.smtp.host", SMTP_HOST);
    //     props.put("mail.smtp.port", SMTP_PORT);
        
    //     Session session = Session.getInstance(props, new Authenticator() {
    //         @Override
    //         protected PasswordAuthentication getPasswordAuthentication() {
    //             return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
    //         }
    //     });
        
    //     try {
    //         Message message = new MimeMessage(session);
    //         message.setFrom(new InternetAddress(EMAIL_FROM));
    //         message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
    //         message.setSubject("Pahana Smart Bill - Email Verification");
    //         message.setText("Your verification code is: " + otp + "\n\nThis code will expire in 10 minutes.\n\nBest regards,\nPahana Smart Bill Team");
            
    //         Transport.send(message);
    //         return true;
    //     } catch (MessagingException e) {
    //         System.err.println("Error sending email: " + e.getMessage());
    //         return false;
    //     }
    // }
    
    // public static boolean sendWelcomeEmail(String toEmail, String username) {
    //     Properties props = new Properties();
    //     props.put("mail.smtp.auth", "true");
    //     props.put("mail.smtp.starttls.enable", "true");
    //     props.put("mail.smtp.host", SMTP_HOST);
    //     props.put("mail.smtp.port", SMTP_PORT);
        
    //     Session session = Session.getInstance(props, new Authenticator() {
    //         @Override
    //         protected PasswordAuthentication getPasswordAuthentication() {
    //             return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
    //         }
    //     });
        
    //     try {
    //         Message message = new MimeMessage(session);
    //         message.setFrom(new InternetAddress(EMAIL_FROM));
    //         message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
    //         message.setSubject("Welcome to Pahana Smart Bill");
    //         message.setText("Dear " + username + ",\n\nWelcome to Pahana Smart Bill! Your account has been successfully created.\n\nYou can now login to your dashboard.\n\nBest regards,\nPahana Smart Bill Team");
            
    //         Transport.send(message);
    //         return true;
    //     } catch (MessagingException e) {
    //         System.err.println("Error sending welcome email: " + e.getMessage());
    //         return false;
    //     }
    // }
} 