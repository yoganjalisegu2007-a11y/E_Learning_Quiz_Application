<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="e_learning.DBConnection" %>

<%
    // 🔐 Check student login

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>📚 Select Subject</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            min-height: 100vh;

            font-family: Arial, sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #dce6f5,
                    #f4f6f9
                );

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 30px;
        }

        .container {
            width: 520px;

            max-width: 100%;

            background: white;

            padding: 40px;

            border-radius: 18px;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.12);

            text-align: center;
        }

        .student-image {
            width: 150px;

            height: 150px;

            margin: 0 auto 20px auto;

            border-radius: 50%;

            background: #e8eef7;

            display: flex;

            justify-content: center;

            align-items: center;

            color: #0B2D5C;

            font-size: 70px;

            box-shadow:
                0 5px 15px
                rgba(11,45,92,0.15);
        }

        .thinking-text {
            color: #0B2D5C;

            font-size: 14px;

            font-weight: bold;

            margin-bottom: 8px;
        }

        h1 {
            color: #333;

            margin: 5px 0 10px 0;

            font-size: 30px;
        }

        .subtitle {
            color: #777;

            font-size: 14px;

            line-height: 1.6;

            margin-bottom: 25px;
        }

        select {
            width: 100%;

            padding: 14px;

            border:
                2px solid #e1e5eb;

            border-radius: 10px;

            background: #fafafa;

            color: #333;

            font-size: 15px;

            outline: none;

            cursor: pointer;

            transition: 0.3s;
        }

        select:focus {
            border-color: #0B2D5C;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(11,45,92,0.10);
        }

        button {
            width: 100%;

            margin-top: 20px;

            padding: 13px 25px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-size: 16px;

            font-weight: bold;

            transition: 0.3s;
        }

        button:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 8px 18px
                rgba(11,45,92,0.25);
        }

        .back {
            display: inline-block;

            margin-top: 18px;

            color: #0B2D5C;

            text-decoration: none;

            font-size: 14px;

            font-weight: bold;
        }

        .back:hover {
            text-decoration: underline;
        }

        .info {
            margin-top: 25px;

            padding: 12px;

            background: #f4f7fb;

            border-radius: 8px;

            color: #666;

            font-size: 12px;

            line-height: 1.5;
        }

        @media (max-width: 600px) {

            body {
                padding: 20px;
            }

            .container {
                padding: 30px 22px;
            }

            .student-image {
                width: 120px;

                height: 120px;

                font-size: 55px;
            }

            h1 {
                font-size: 26px;
            }

        }

    </style>

</head>

<body>


<div class="container">


    <!-- 👨‍💻 Student Visual -->

    <div class="student-image">

        🧑‍💻

    </div>


    <div class="thinking-text">

        🚀 READY TO LEARN?

    </div>


    <h1>

        📚 Select Your Subject

    </h1>


    <p class="subtitle">

        Choose a subject below and
        start your quiz. Test your
        knowledge and improve your skills! 💪

    </p>


    <!-- 📚 Subject Selection -->

    <form
        action="QuizServlet"
        method="get">


        <select
            name="subjectId"
            required>


            <option value="">

                📚 -- Select Subject --

            </option>


            <%

                try {

                    Connection con =
                        DBConnection.getConnection();


                    String sql =
                        "SELECT id, subject_name " +
                        "FROM subjects " +
                        "ORDER BY id";


                    PreparedStatement ps =
                        con.prepareStatement(sql);


                    ResultSet rs =
                        ps.executeQuery();


                    while (rs.next()) {

            %>


                        <option
                            value="<%= rs.getInt("id") %>">

                            📖 <%= rs.getString("subject_name") %>

                        </option>


            <%

                    }


                    rs.close();

                    ps.close();

                    con.close();


                } catch (Exception e) {

                    e.printStackTrace();

            %>


                    <option value="">

                        ⚠️ Error loading subjects

                    </option>


            <%

                }

            %>


        </select>


        <button type="submit">

            🚀 Start Quiz

        </button>


    </form>


    <!-- 🏠 Back -->

    <a
        href="dashboard.jsp"
        class="back">

        🏠 Back to Dashboard

    </a>


    <!-- 💡 Information -->

    <div class="info">

        💡 Tip: Choose a subject and
        challenge yourself with the questions!

    </div>


</div>


</body>

</html>