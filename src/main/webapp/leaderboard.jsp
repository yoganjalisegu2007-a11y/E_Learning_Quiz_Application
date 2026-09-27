<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%
    // Check student login

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }

    ArrayList<String[]> leaderboard =
        (ArrayList<String[]>) request.getAttribute("leaderboard");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>🏆 Leaderboard</title>

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
            min-height: 100vh;
            background: #f4f6f9;
        }

        .header {
            background: #0B2D5C;
            color: white;

            padding: 20px 45px;

            box-shadow:
                0 3px 12px
                rgba(0,0,0,0.12);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .container {
            width: 90%;
            max-width: 1100px;

            margin: 40px auto;

            background: white;

            padding: 35px;

            border-radius: 16px;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.10);
        }

        .title-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .leader-icon {
            width: 70px;
            height: 70px;

            margin: 0 auto 15px;

            border-radius: 50%;

            background: #e8eef7;

            color: #0B2D5C;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 30px;
        }

        h1 {
            color: #2d3436;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            font-size: 14px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;

            border-collapse: collapse;

            min-width: 650px;
        }

        th {
            background: #0B2D5C;

            color: white;

            padding: 15px;

            text-align: center;

            font-size: 14px;
        }

        td {
            padding: 14px;

            text-align: center;

            border-bottom:
                1px solid #e5e5e5;

            color: #444;

            font-size: 14px;
        }

        tr:hover {
            background: #f4f6f9;
        }

        .rank {
            font-weight: bold;
            color: #0B2D5C;
        }

        .student-name {
            font-weight: bold;
            color: #333;
        }

        .score {
            font-weight: bold;
            color: #0B2D5C;
        }

        .percentage {
            font-weight: bold;
            color: #0B2D5C;
        }

        .empty {
            text-align: center;

            padding: 40px;

            color: #777;

            background: #f8f9fb;

            border-radius: 10px;
        }

        .buttons {
            text-align: center;

            margin-top: 30px;
        }

        .buttons a {
            display: inline-block;

            padding: 12px 22px;

            margin: 5px;

            text-decoration: none;

            background: #0B2D5C;

            color: white;

            border-radius: 7px;

            font-size: 14px;

            font-weight: bold;

            transition: 0.3s;
        }

        .buttons a:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 7px 15px
                rgba(11,45,92,0.20);
        }

        @media (max-width: 700px) {

            .header {
                padding: 18px 25px;
            }

            .container {
                width: 94%;

                padding: 25px 15px;
            }

            h1 {
                font-size: 25px;
            }

        }

    </style>

</head>

<body>


<!-- Header -->

<div class="header">

    <div class="logo">

        🎓 E-LEARN

    </div>

</div>


<div class="container">


    <!-- Title -->

    <div class="title-section">

        <div class="leader-icon">

            🏆

        </div>

        <h1>

            🏆 Student Leaderboard

        </h1>

        <p class="subtitle">

            📊 View student quiz performance and rankings

        </p>

    </div>


<%

    if (leaderboard == null ||
        leaderboard.isEmpty()) {

%>


    <!-- No Results -->

    <div class="empty">

        📭 No quiz results available yet.

    </div>


<%

    } else {

%>


    <!-- Leaderboard Table -->

    <div class="table-wrapper">

        <table>

            <tr>

                <th>
                    🏅 Rank
                </th>

                <th>
                    👤 Student Name
                </th>

                <th>
                    📝 Score
                </th>

                <th>
                    ❓ Total Questions
                </th>

                <th>
                    📊 Percentage
                </th>

            </tr>


<%

        int rank = 1;

        for (String[] row : leaderboard) {

%>


            <tr>

                <td class="rank">

                    🏅 <%= rank %>

                </td>

                <td class="student-name">

                    👤 <%= row[0] %>

                </td>

                <td class="score">

                    ⭐ <%= row[1] %>

                </td>

                <td>

                    ❓ <%= row[2] %>

                </td>

                <td class="percentage">

                    📈 <%= row[3] %>%

                </td>

            </tr>


<%

            rank++;

        }

%>


        </table>

    </div>


<%

    }

%>


    <!-- Buttons -->

    <div class="buttons">

        <a href="dashboard.jsp">

            🏠 Back to Dashboard

        </a>

        <a href="selectSubject.jsp">

            📝 Take Another Quiz

        </a>

    </div>


</div>

</body>

</html>