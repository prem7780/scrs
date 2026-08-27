package com.scrs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import com.scrs.util.DBConnection;

public class CertificateRequestDAO {

    public long createRequest(
            String rollNumber,
            String fullName,
            String email,
            String course,
            int year,
            String academicStatus,
            String departmentCode,
            String certificateType,
            String purpose,
            LocalDate requiredBy,
            String remarks) throws SQLException {

        String departmentSql =
                "SELECT department_id " +
                        "FROM department " +
                        "WHERE department_code = ? " +
                        "AND is_active = 1";

        String typeSql =
                "SELECT type_id " +
                        "FROM certificate_type " +
                        "WHERE type_name = ? " +
                        "AND is_active = 1";

        String statusSql =
                "SELECT status_id " +
                        "FROM request_status " +
                        "WHERE status_name = 'PENDING'";

        String insertSql =
                "INSERT INTO certificate_request " +
                        "(roll_no, full_name, email, course, year, " +
                        "academic_status, department_id, type_id, purpose, " +
                        "required_by, remarks, status_id) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection()) {

            int departmentId;
            int typeId;
            int statusId;

            // --------------------------------
            // Department
            // --------------------------------

            try (PreparedStatement ps =
                         connection.prepareStatement(departmentSql)) {

                ps.setString(1, departmentCode);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        throw new SQLException(
                                "Invalid department code: "
                                        + departmentCode
                        );
                    }

                    departmentId =
                            rs.getInt("department_id");
                }
            }

            // --------------------------------
            // Certificate Type
            // --------------------------------

            try (PreparedStatement ps =
                         connection.prepareStatement(typeSql)) {

                ps.setString(1, certificateType);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        throw new SQLException(
                                "Invalid certificate type: "
                                        + certificateType
                        );
                    }

                    typeId =
                            rs.getInt("type_id");
                }
            }

            // --------------------------------
            // PENDING Status
            // --------------------------------

            try (PreparedStatement ps =
                         connection.prepareStatement(statusSql)) {

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        throw new SQLException(
                                "PENDING status not configured."
                        );
                    }

                    statusId =
                            rs.getInt("status_id");
                }
            }

            // --------------------------------
            // Insert Request
            // --------------------------------

            try (PreparedStatement ps =
                         connection.prepareStatement(
                                 insertSql,
                                 Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, rollNumber);
                ps.setString(2, fullName);
                ps.setString(3, email);
                ps.setString(4, course);
                ps.setInt(5, year);
                ps.setString(6, academicStatus);
                ps.setInt(7, departmentId);
                ps.setInt(8, typeId);
                ps.setString(9, purpose);
                ps.setDate(
                        10,
                        java.sql.Date.valueOf(requiredBy)
                );
                ps.setString(11, remarks);
                ps.setInt(12, statusId);

                int rowsAffected =
                        ps.executeUpdate();

                if (rowsAffected == 0) {
                    throw new SQLException(
                            "Certificate request was not created."
                    );
                }

                try (ResultSet rs =
                             ps.getGeneratedKeys()) {

                    if (rs.next()) {
                        return rs.getLong(1);
                    }

                    throw new SQLException(
                            "Request ID could not be generated."
                    );
                }
            }
        }
    }
}