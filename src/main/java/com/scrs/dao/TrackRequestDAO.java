package com.scrs.dao;

import com.scrs.model.RequestTracking;
import com.scrs.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TrackRequestDAO {

    public RequestTracking getRequestStatus(long requestId)
            throws SQLException {

        String sql =
                "SELECT cr.request_id, rs.status_name " +
                        "FROM certificate_request cr " +
                        "JOIN request_status rs " +
                        "ON cr.status_id = rs.status_id " +
                        "WHERE cr.request_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setLong(1, requestId);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                RequestTracking tracking =
                        new RequestTracking();

                tracking.setRequestId(
                        rs.getLong("request_id")
                );

                tracking.setStatus(
                        rs.getString("status_name")
                );

                return tracking;
            }
        }
    }
}