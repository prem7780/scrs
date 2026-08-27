package com.scrs.controller;

import com.scrs.dao.TrackRequestDAO;
import com.scrs.model.RequestTracking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/track-request")
public class TrackRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Request ID is required."
            );

            return;
        }

        long requestId;

        try {

            requestId = Long.parseLong(id);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid request ID."
            );

            return;
        }

        TrackRequestDAO dao =
                new TrackRequestDAO();

        try {

            RequestTracking tracking =
                    dao.getRequestStatus(requestId);

            if (tracking == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Certificate request not found."
                );

                return;
            }

            request.setAttribute(
                    "tracking",
                    tracking
            );

            request.getRequestDispatcher(
                    "/student/track-request.jsp"
            ).forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to retrieve request status.",
                    e
            );
        }
    }
}