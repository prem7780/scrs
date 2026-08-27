//package com.scrs.util;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBConnection {
//
////    private static final String url ="jdbc:mysql://localhost:3306/scrs_db";
////
////    private static final String user ="root";
////
////    private static final String pwd ="prem";
////
////    public static Connection getConnection()
////            throws SQLException {
////
////        return DriverManager.getConnection(
////                url,
////                user,
////                pwd
////        );
////    }
//
//}

package com.scrs.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/scrs_db";

    private static final String USER = System.getenv("SCRS_DB_USER");

    private static final String PASSWORD = System.getenv("SCRS_DB_PASSWORD");

    public static Connection getConnection()
            throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println(
                    "MySQL Driver loaded: "
                            + com.mysql.cj.jdbc.Driver.class
            );

        } catch (ClassNotFoundException e) {

            throw new SQLException(
                    "MySQL Driver class could not be loaded.",
                    e
            );
        }

        System.out.println(
                "JDBC URL: " + URL
        );

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}