<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="e_learning.DBConnection" %>

<%@ page session="true" %>

<%
    String adminUsername =
            (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {

        response.sendRedirect("adminLogin.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Subjects</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f6f9;
            min-height: 100vh;
        }

        .header {
            background: #0B2D5C;
            color: white;

            padding: 22px 45px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            box-shadow:
                0 3px 12px
                rgba(0,0,0,0.12);
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .admin-name {
            font-size: 14px;
        }

        .container {
            width: 90%;
            max-width: 850px;

            margin: 40px auto;
        }

        .box {
            background: white;

            padding: 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 18px
                rgba(0,0,0,0.08);

            margin-bottom: 25px;
        }

        .box h2 {
            color: #0B2D5C;

            margin-bottom: 22px;

            font-size: 22px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;

            color: #444;

            font-size: 14px;

            font-weight: bold;

            margin-bottom: 8px;
        }

        input[type="text"] {
            width: 100%;

            height: 48px;

            padding: 0 14px;

            border:
                2px solid #eeeeee;

            border-radius: 9px;

            outline: none;

            font-size: 14px;

            background: #fafafa;

            transition: 0.3s;
        }

        input[type="text"]:focus {
            border-color: #0B2D5C;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(11,45,92,0.08);
        }

        .add-button {
            margin-top: 10px;

            padding: 12px 25px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-size: 15px;

            font-weight: bold;

            transition: 0.3s;
        }

        .add-button:hover {
            background: #071F40;

            transform:
                translateY(-2px);
        }

        table {
            width: 100%;

            border-collapse: collapse;

            margin-top: 10px;
        }

        th {
            background: #0B2D5C;

            color: white;

            padding: 14px;

            text-align: center;

            font-size: 14px;
        }

        td {
            padding: 14px;

            border-bottom:
                1px solid #eeeeee;

            text-align: center;

            color: #555;

            font-size: 14px;
        }

        tr:hover td {
            background: #f7f9fc;
        }

        .no-data {
            color: #888;

            padding: 25px;

            text-align: center;
        }

        .error {
            color: #c0392b;

            padding: 15px;

            text-align: center;

            font-size: 14px;
        }

        .back {
            display: inline-block;

            padding: 11px 20px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-weight: bold;

            transition: 0.3s;
        }

        .back:hover {
            background: #071F40;

            transform:
                translateY(-2px);
        }

        @media (max-width: 650px) {

            .header {
                padding: 18px 20px;

                flex-direction: column;

                gap: 8px;

                text-align: center;
            }

            .container {
                width: 94%;
            }

            .box {
                padding: 22px;
            }

            table {
                font-size: 13px;
            }

            th,
            td {
                padding: 10px 6px;
            }

        }

    </style>

</head>

<body>


<!-- Header -->

<div class="header">

    <h1>
        📚 Manage Subjects
    </h1>

    <div class="admin-name">

        👤 Welcome,
        <strong>
            <%= adminUsername %>
        </strong>

    </div>

</div>


<div class="container">


    <!-- Add Subject -->

    <div class="box">

        <h2>
            ➕ Add New Subject
        </h2>

        <form
            action="AddSubjectServlet"
            method="post">

            <div class="form-group">

                <label>
                    📚 Subject Name
                </label>

                <input
                    type="text"
                    name="subjectName"
                    placeholder="Enter subject name"
                    required>

            </div>


            <button
                type="submit"
                class="add-button">

                ➕ Add Subject

            </button>

        </form>

    </div>


    <!-- Existing Subjects -->

    <div class="box">

        <h2>
            📋 Existing Subjects
        </h2>

        <table>

            <tr>

                <th>
                    🆔 ID
                </th>

                <th>
                    📚 Subject Name
                </th>

            </tr>


<%

    String sql =
            "SELECT id, subject_name " +
            "FROM subjects " +
            "ORDER BY id";

    try {

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        boolean hasSubjects = false;


        while (rs.next()) {

            hasSubjects = true;

%>

            <tr>

                <td>
                    <%= rs.getInt("id") %>
                </td>

                <td>
                    📚 <%= rs.getString("subject_name") %>
                </td>

            </tr>


<%

        }


        if (!hasSubjects) {

%>

            <tr>

                <td
                    colspan="2"
                    class="no-data">

                    🤔 No subjects available.

                </td>

            </tr>


<%

        }


        rs.close();

        ps.close();

        con.close();


    } catch (Exception e) {

%>

            <tr>

                <td
                    colspan="2"
                    class="error">

                    ⚠️ Error loading subjects:
                    <%= e.getMessage() %>

                </td>

            </tr>


<%

    }

%>


        </table>

    </div>


    <!-- Back -->

    <a
        href="adminDashboard.jsp"
        class="back">

        ↩️ Back to Admin Dashboard

    </a>


</div>

</body>

</html>