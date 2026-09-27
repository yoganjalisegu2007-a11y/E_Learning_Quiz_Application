<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="e_learning.DBConnection" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>📚 View Syllabus - E-Learn</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #222;
        }

        /* 🔵 HEADER */

        .header {
            background: #0B2D5C;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .header p {
            margin: 8px 0 0;
            font-size: 15px;
        }

        /* 📚 MAIN CONTAINER */

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto;
        }

        /* 🖼️ SYLLABUS IMAGE */

        .image-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .syllabus-image {
            width: 100%;
            max-width: 800px;
            height: 250px;
            object-fit: cover;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.20);
        }

        /* 📖 TITLE */

        .section-title {
            text-align: center;
            color: #0B2D5C;
            margin-bottom: 25px;
        }

        /* 📚 SYLLABUS CARD */

        .syllabus-card {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.10);
            border-left: 6px solid #0B2D5C;
        }

        .subject-name {
            color: #0B2D5C;
            font-size: 23px;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .syllabus-title {
            font-size: 19px;
            color: #333;
            margin-bottom: 10px;
        }

        .syllabus-content {
            color: #555;
            line-height: 1.7;
            font-size: 16px;
            white-space: pre-line;
        }

        /* 🏠 BACK BUTTON */

        .back-container {
            text-align: center;
            margin: 35px 0;
        }

        .back-button {
            display: inline-block;
            text-decoration: none;
            background: #0B2D5C;
            color: white;
            padding: 13px 25px;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s;
        }

        .back-button:hover {
            background: #071F40;
        }

        /* 📱 MOBILE */

        @media (max-width: 600px) {

            .container {
                width: 94%;
            }

            .header h1 {
                font-size: 24px;
            }

            .syllabus-image {
                height: 180px;
            }

            .syllabus-card {
                padding: 18px;
            }

        }

    </style>

</head>

<body>

    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>📚 E-Learn Syllabus</h1>

        <p>
            🎓 Explore your subjects and learning topics
        </p>

    </div>


    <!-- 📚 MAIN -->

    <div class="container">


        <!-- 🖼️ SYLLABUS IMAGE -->

        <div class="image-container">

            <img
                src="<%= request.getContextPath() %>/images/syllabus.png"
                alt="📚 Syllabus"
                class="syllabus-image">

        </div>


        <h2 class="section-title">
            📖 Available Syllabus
        </h2>


        <%

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {

                con = DBConnection.getConnection();

                String sql =
                    "SELECT s.subject_name, " +
                    "sy.title, sy.content " +
                    "FROM syllabus sy " +
                    "JOIN subjects s " +
                    "ON sy.subject_id = s.id " +
                    "ORDER BY s.subject_name, sy.id";

                ps = con.prepareStatement(sql);

                rs = ps.executeQuery();

                boolean found = false;

                while (rs.next()) {

                    found = true;

        %>


        <!-- 📚 SYLLABUS CARD -->

        <div class="syllabus-card">

            <h2 class="subject-name">

                📘 <%= rs.getString("subject_name") %>

            </h2>


            <h3 class="syllabus-title">

                📝 <%= rs.getString("title") %>

            </h3>


            <div class="syllabus-content">

                <%= rs.getString("content") %>

            </div>

        </div>


        <%

                }

                if (!found) {

        %>

        <div class="syllabus-card">

            <h2 class="subject-name">
                📭 No Syllabus Available
            </h2>

            <p class="syllabus-content">
                📚 Syllabus information has not been added yet.
            </p>

        </div>

        <%

                }

            } catch (Exception e) {

        %>

        <div class="syllabus-card">

            <h2 class="subject-name">
                ❌ Error Loading Syllabus
            </h2>

            <p class="syllabus-content">
                <%= e.getMessage() %>
            </p>

        </div>

        <%

            } finally {

                try {
                    if (rs != null) rs.close();
                } catch (Exception e) {}

                try {
                    if (ps != null) ps.close();
                } catch (Exception e) {}

                try {
                    if (con != null) con.close();
                } catch (Exception e) {}

            }

        %>


        <!-- 🏠 BACK BUTTON -->

        <div class="back-container">

            <a
                href="<%= request.getContextPath() %>/dashboard.jsp"
                class="back-button">

                🏠 Back to Dashboard

            </a>

        </div>

    </div>

</body>

</html>