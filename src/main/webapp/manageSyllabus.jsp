<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // 🔐 Check admin login

    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("adminLogin.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>📚 Manage Syllabus</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            font-family: Arial, sans-serif;

            background: #f4f6f9;

            color: #333;
        }

        .header {
            background: #0B2D5C;

            color: white;

            padding: 20px 40px;

            box-shadow:
                0 3px 12px
                rgba(0,0,0,0.12);
        }

        .header h1 {
            margin: 0;

            font-size: 25px;
        }

        .container {
            width: 90%;

            max-width: 1200px;

            margin: 35px auto;

            background: white;

            padding: 35px;

            border-radius: 16px;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.10);
        }

        .page-title {
            text-align: center;

            margin-bottom: 30px;
        }

        .page-icon {
            width: 70px;

            height: 70px;

            margin: 0 auto 15px;

            border-radius: 50%;

            background: #e8eef7;

            color: #0B2D5C;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 32px;
        }

        .page-title h2 {
            margin: 0 0 8px;

            color: #2d3436;

            font-size: 30px;
        }

        .page-title p {
            margin: 0;

            color: #777;

            font-size: 14px;
        }

        .section {
            margin-top: 30px;

            padding: 25px;

            background: #f8f9fb;

            border-radius: 12px;

            border-left: 5px solid #0B2D5C;
        }

        .section h3 {
            margin-top: 0;

            color: #0B2D5C;

            font-size: 21px;
        }

        label {
            display: block;

            margin-top: 17px;

            font-weight: bold;

            color: #444;

            font-size: 14px;
        }

        select,
        input,
        textarea {
            width: 100%;

            padding: 12px;

            margin-top: 7px;

            border:
                1px solid #d9dfe8;

            border-radius: 7px;

            font-size: 14px;

            background: white;

            outline: none;
        }

        select:focus,
        input:focus,
        textarea:focus {
            border-color: #0B2D5C;

            box-shadow:
                0 0 0 3px
                rgba(11,45,92,0.10);
        }

        textarea {
            height: 180px;

            resize: vertical;
        }

        .add-button {
            margin-top: 22px;

            padding: 12px 25px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 7px;

            cursor: pointer;

            font-weight: bold;

            font-size: 14px;

            transition: 0.3s;
        }

        .add-button:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 7px 15px
                rgba(11,45,92,0.20);
        }

        .existing-title {
            margin-top: 40px;

            color: #2d3436;

            font-size: 23px;
        }

        .table-wrapper {
            overflow-x: auto;

            margin-top: 18px;
        }

        table {
            width: 100%;

            border-collapse: collapse;

            min-width: 850px;

            background: white;
        }

        th {
            background: #0B2D5C;

            color: white;

            padding: 14px;

            text-align: left;

            font-size: 14px;
        }

        td {
            padding: 13px;

            border-bottom:
                1px solid #e5e5e5;

            vertical-align: top;

            font-size: 14px;

            color: #444;

            line-height: 1.5;
        }

        tr:hover {
            background: #f4f6f9;
        }

        .edit-button {
            display: inline-block;

            padding: 8px 14px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 5px;

            margin-right: 5px;

            font-size: 13px;

            font-weight: bold;

            transition: 0.3s;
        }

        .edit-button:hover {
            background: #071F40;
        }

        .delete-button {
            display: inline-block;

            padding: 8px 14px;

            background: #8b1e1e;

            color: white;

            text-decoration: none;

            border-radius: 5px;

            font-size: 13px;

            font-weight: bold;

            transition: 0.3s;
        }

        .delete-button:hover {
            background: #651414;
        }

        .back {
            display: inline-block;

            margin-top: 30px;

            padding: 11px 20px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: bold;

            transition: 0.3s;
        }

        .back:hover {
            background: #071F40;

            transform:
                translateY(-2px);
        }

        .error {
            margin-top: 15px;

            padding: 12px;

            background: #fff1f1;

            color: #8b1e1e;

            border-radius: 7px;
        }

        @media (max-width: 700px) {

            .container {
                width: 94%;

                padding: 22px 15px;
            }

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 21px;
            }

            .page-title h2 {
                font-size: 25px;
            }

            .section {
                padding: 18px;
            }

        }

    </style>

</head>

<body>


<!-- 🔷 Header -->

<div class="header">

    <h1>

        🎓 E-Learning Quiz Application

    </h1>

</div>


<div class="container">


    <!-- 📚 Page Title -->

    <div class="page-title">

        <div class="page-icon">

            📚

        </div>

        <h2>

            Manage Syllabus

        </h2>

        <p>

            ➕ Add, ✏️ edit and 🗑️ delete syllabus content

        </p>

    </div>


    <!-- ➕ ADD SYLLABUS -->

    <div class="section">

        <h3>

            ➕ Add New Syllabus

        </h3>


        <form
            action="AddSyllabusServlet"
            method="post">


            <!-- 📚 Subject -->

            <label>

                📚 Select Subject

            </label>

            <select
                name="subjectId"
                required>

                <option value="">

                    -- Select Subject --

                </option>


<%

    String subjectSQL =
        "SELECT id, subject_name " +
        "FROM subjects " +
        "ORDER BY subject_name";

    try {

        Connection con =
            e_learning.DBConnection.getConnection();

        PreparedStatement ps =
            con.prepareStatement(subjectSQL);

        ResultSet rs =
            ps.executeQuery();

        while (rs.next()) {

%>

                <option
                    value="<%= rs.getInt("id") %>">

                    <%= rs.getString("subject_name") %>

                </option>

<%

        }

        rs.close();

        ps.close();

        con.close();

    } catch (Exception e) {

%>

                <option value="">

                    Unable to load subjects

                </option>

<%

    }

%>

            </select>


            <!-- 📝 Title -->

            <label>

                📝 Syllabus Title

            </label>

            <input
                type="text"
                name="title"
                placeholder="Example: Unit 1 - Introduction"
                required>


            <!-- 📖 Content -->

            <label>

                📖 Syllabus Content

            </label>

            <textarea
                name="content"
                placeholder="Enter syllabus topics here..."
                required></textarea>


            <!-- ➕ Add -->

            <button
                type="submit"
                class="add-button">

                ➕ Add Syllabus

            </button>


        </form>

    </div>


    <!-- 📚 EXISTING SYLLABUS -->

    <h2 class="existing-title">

        📋 Existing Syllabus

    </h2>


    <div class="table-wrapper">

        <table>

            <tr>

                <th>
                    📚 Subject
                </th>

                <th>
                    📝 Title
                </th>

                <th>
                    📖 Content
                </th>

                <th>
                    ⚙️ Actions
                </th>

            </tr>


<%

    String syllabusSQL =
        "SELECT sy.id, " +
        "s.subject_name, " +
        "sy.title, " +
        "sy.content " +
        "FROM syllabus sy " +
        "JOIN subjects s " +
        "ON sy.subject_id = s.id " +
        "ORDER BY s.subject_name";

    try {

        Connection con =
            e_learning.DBConnection.getConnection();

        PreparedStatement ps =
            con.prepareStatement(syllabusSQL);

        ResultSet rs =
            ps.executeQuery();

        boolean hasData = false;

        while (rs.next()) {

            hasData = true;

%>

            <tr>

                <!-- 📚 Subject -->

                <td>

                    📚
                    <%= rs.getString("subject_name") %>

                </td>


                <!-- 📝 Title -->

                <td>

                    📝
                    <%= rs.getString("title") %>

                </td>


                <!-- 📖 Content -->

                <td>

                    <%= rs.getString("content") %>

                </td>


                <!-- ⚙️ Actions -->

                <td>

                    <a
                        href="EditSyllabusServlet?id=<%= rs.getInt("id") %>"
                        class="edit-button">

                        ✏️ Edit

                    </a>


                    <a
                        href="DeleteSyllabusServlet?id=<%= rs.getInt("id") %>"
                        class="delete-button"
                        onclick="return confirm('Are you sure you want to delete this syllabus?');">

                        🗑️ Delete

                    </a>

                </td>

            </tr>

<%

        }

        if (!hasData) {

%>

            <tr>

                <td
                    colspan="4"
                    style="text-align:center; padding:30px;">

                    📭 No syllabus available yet.

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
                    colspan="4"
                    class="error">

                    ❌ Error loading syllabus:
                    <%= e.getMessage() %>

                </td>

            </tr>

<%

    }

%>

        </table>

    </div>


    <!-- ↩️ Back -->

    <a
        href="adminDashboard.jsp"
        class="back">

        ↩️ Back to Admin Dashboard

    </a>


</div>

</body>

</html>