<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="e_learning.DBConnection" %>

<%
    // Check admin login

    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("adminLogin.jsp");

        return;
    }

    Integer syllabusId =
            (Integer) request.getAttribute("syllabusId");

    Integer selectedSubjectId =
            (Integer) request.getAttribute("subjectId");

    String title =
            (String) request.getAttribute("title");

    String content =
            (String) request.getAttribute("content");

    if (syllabusId == null) {

        response.sendRedirect("manageSyllabus.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>✏️ Edit Syllabus</title>

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

            padding: 32px;

            border-radius: 16px;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.08);
        }

        .box h2 {
            color: #0B2D5C;

            margin-bottom: 25px;

            font-size: 23px;
        }

        .syllabus-id {
            display: inline-block;

            background: #e8eef7;

            color: #0B2D5C;

            padding: 8px 13px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: bold;

            margin-bottom: 15px;
        }

        label {
            display: block;

            margin-top: 18px;

            margin-bottom: 7px;

            color: #444;

            font-size: 14px;

            font-weight: bold;
        }

        select,
        input[type="text"],
        textarea {
            width: 100%;

            padding: 12px;

            border:
                2px solid #eeeeee;

            border-radius: 9px;

            font-size: 14px;

            outline: none;

            background: #fafafa;

            transition: 0.3s;
        }

        select:focus,
        input[type="text"]:focus,
        textarea:focus {
            border-color: #0B2D5C;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(11,45,92,0.08);
        }

        textarea {
            min-height: 220px;

            resize: vertical;

            line-height: 1.6;
        }

        .buttons {
            margin-top: 28px;

            display: flex;

            gap: 12px;

            flex-wrap: wrap;
        }

        .update {
            padding: 13px 24px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-size: 15px;

            font-weight: bold;

            transition: 0.3s;
        }

        .update:hover {
            background: #071F40;

            transform:
                translateY(-2px);
        }

        .back {
            display: inline-block;

            padding: 13px 24px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-size: 15px;

            font-weight: bold;

            transition: 0.3s;
        }

        .back:hover {
            background: #071F40;

            transform:
                translateY(-2px);
        }

        .error {
            color: #c0392b;

            margin-top: 10px;

            padding: 10px;

            background: #fdecea;

            border-radius: 6px;
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

            .buttons {
                flex-direction: column;
            }

            .update,
            .back {
                width: 100%;

                text-align: center;
            }

        }

    </style>

</head>

<body>


<!-- Header -->

<div class="header">

    <h1>
        ✏️ Edit Syllabus
    </h1>

    <div class="admin-name">

        👤 Welcome,
        <strong>
            <%= session.getAttribute("adminUsername") %>
        </strong>

    </div>

</div>


<div class="container">

    <div class="box">


        <!-- Syllabus ID -->

        <div class="syllabus-id">

            🆔 Syllabus ID:
            <%= syllabusId %>

        </div>


        <h2>
            📖 Update Syllabus
        </h2>


        <form
            action="EditSyllabusServlet"
            method="post">


            <!-- Hidden ID -->

            <input
                type="hidden"
                name="id"
                value="<%= syllabusId %>">


            <!-- Subject -->

            <label>
                📚 Select Subject
            </label>

            <select
                name="subjectId"
                required>

                <option value="">
                    📚 Select Subject
                </option>


<%
                String sql =
                    "SELECT id, subject_name " +
                    "FROM subjects " +
                    "ORDER BY subject_name";

                try {

                    Connection con =
                            DBConnection.getConnection();

                    PreparedStatement ps =
                            con.prepareStatement(sql);

                    ResultSet rs =
                            ps.executeQuery();


                    while (rs.next()) {

                        int subjectId =
                                rs.getInt("id");

                        String subjectName =
                                rs.getString("subject_name");

                        boolean selected =
                                subjectId ==
                                selectedSubjectId;

%>

                <option
                    value="<%= subjectId %>"
                    <%= selected
                        ? "selected"
                        : "" %>>

                    <%= subjectName %>

                </option>

<%

                    }

                    rs.close();

                    ps.close();

                    con.close();

                } catch (Exception e) {

%>

                <option value="">
                    ⚠️ Error loading subjects
                </option>

                <div class="error">

                    ⚠️ Error loading subjects:
                    <%= e.getMessage() %>

                </div>

<%

                }

%>

            </select>


            <!-- Title -->

            <label>
                📝 Syllabus Title
            </label>

            <input
                type="text"
                name="title"
                value="<%= title %>"
                required>


            <!-- Content -->

            <label>
                📖 Syllabus Content
            </label>

            <textarea
                name="content"
                required><%= content %></textarea>


            <!-- Buttons -->

            <div class="buttons">

                <button
                    type="submit"
                    class="update">

                    💾 Update Syllabus

                </button>


                <a
                    href="manageSyllabus.jsp"
                    class="back">

                    ↩️ Cancel

                </a>

            </div>


        </form>

    </div>

</div>

</body>

</html>