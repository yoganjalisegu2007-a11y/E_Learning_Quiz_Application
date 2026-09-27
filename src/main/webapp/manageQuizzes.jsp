<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%
    String adminUsername =
            (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    ArrayList<String[]> quizzes =
            (ArrayList<String[]>) request.getAttribute("quizzes");

    if (quizzes == null) {
        quizzes = new ArrayList<String[]>();
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>📋 Manage Quizzes</title>

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

        /* 🔵 HEADER */

        .header {

            background: #0B2D5C;

            color: white;

            padding: 30px 20px;

            text-align: center;
        }

        .header h1 {

            margin: 0;

            font-size: 38px;
        }

        /* 📦 MAIN CONTAINER */

        .container {

            width: 95%;

            max-width: 1400px;

            margin: 35px auto;
        }

        /* 📝 SECTION TITLE */

        .section-title {

            color: #0B2D5C;

            font-size: 30px;

            margin-bottom: 25px;

            font-weight: bold;
        }

        /* 📊 TABLE CONTAINER */

        .table-container {

            background: white;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.10);

            overflow-x: auto;
        }

        /* 📋 TABLE */

        table {

            width: 100%;

            border-collapse: collapse;

            min-width: 1100px;
        }

        /* 🔵 TABLE HEADER */

        th {

            background: #0B2D5C;

            color: white;

            padding: 18px 15px;

            text-align: center;

            font-size: 16px;
        }

        /* 📄 TABLE DATA */

        td {

            padding: 18px 15px;

            text-align: center;

            border-bottom: 1px solid #ddd;

            font-size: 15px;

            vertical-align: middle;
        }

        tr:last-child td {

            border-bottom: none;
        }

        tr:hover {

            background: #f7f9fc;
        }

        /* 🎯 QUIZ NAME */

        .quiz-name {

            font-weight: bold;

            color: #0B2D5C;
        }

        /* ⏱️ DURATION */

        .duration {

            font-weight: bold;

            color: #444;
        }

        /* 🟢 START TIME */

        .start-time {

            color: #087f23;

            font-weight: bold;

            line-height: 1.6;
        }

        /* 🔴 END TIME */

        .end-time {

            color: #d62828;

            font-weight: bold;

            line-height: 1.6;
        }

        /* ⚙️ ACTION COLUMN */

        .action-cell {

            min-width: 230px;
        }

        /* 📦 ACTION BUTTONS */

        .action-buttons {

            display: flex;

            flex-direction: column;

            align-items: center;

            gap: 12px;
        }

        /* 🔘 COMMON BUTTON */

        .action-button {

            display: block;

            width: 190px;

            padding: 12px 15px;

            border-radius: 7px;

            color: white;

            text-decoration: none;

            font-weight: bold;

            text-align: center;

            transition: 0.3s;

            box-shadow:
                0 2px 5px rgba(0, 0, 0, 0.15);
        }

        /* ➕ ADD QUESTIONS */

        .add-button {

            background: #0B2D5C;
        }

        .add-button:hover {

            background: #071F40;

            transform: translateY(-2px);
        }

        /* 🛠️ MANAGE QUESTIONS */

        .manage-button {

            background: #174A7E;
        }

        .manage-button:hover {

            background: #0B2D5C;

            transform: translateY(-2px);
        }

        /* 📭 NO QUIZZES */

        .no-quizzes {

            text-align: center;

            padding: 50px;

            font-size: 18px;

            color: #777;
        }

        /* 🔙 BACK BUTTON */

        .back-area {

            text-align: center;

            margin-top: 35px;

            margin-bottom: 30px;
        }

        .back-button {

            display: inline-block;

            padding: 13px 28px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: bold;

            transition: 0.3s;
        }

        .back-button:hover {

            background: #071F40;

            transform: translateY(-2px);
        }

        /* 📱 MOBILE */

        @media (max-width: 700px) {

            .header h1 {

                font-size: 28px;
            }

            .container {

                width: 96%;
            }

            .section-title {

                font-size: 24px;
            }

            table {

                min-width: 1000px;
            }
        }

    </style>

</head>


<body>


    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>
            📋 Manage Quizzes
        </h1>

    </div>


    <!-- 📦 MAIN CONTAINER -->

    <div class="container">


        <!-- 📝 SECTION TITLE -->

        <div class="section-title">

            📝 Created Quizzes

        </div>


        <!-- 📊 QUIZ TABLE -->

        <div class="table-container">

            <%
                if (quizzes.size() == 0) {
            %>

                <!-- 📭 NO QUIZZES -->

                <div class="no-quizzes">

                    📭 No quizzes have been created yet.

                </div>

            <%
                } else {
            %>


                <table>

                    <thead>

                        <tr>

                            <th>
                                🆔<br>
                                ID
                            </th>

                            <th>
                                📝<br>
                                Quiz Name
                            </th>

                            <th>
                                📚<br>
                                Subject
                            </th>

                            <th>
                                ⏱️<br>
                                Duration
                            </th>

                            <th>
                                🟢<br>
                                Start Time
                            </th>

                            <th>
                                🔴<br>
                                End Time
                            </th>

                            <th>
                                ⚙️<br>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                    <%
                        for (String[] quiz : quizzes) {

                            String quizId =
                                    quiz[0];

                            String quizName =
                                    quiz[1];

                            String subjectName =
                                    quiz[2];

                            String timeLimit =
                                    quiz[3];

                            String startTime =
                                    quiz[4];

                            String endTime =
                                    quiz[5];
                    %>


                        <tr>


                            <!-- 🆔 QUIZ ID -->

                            <td>

                                <%= quizId %>

                            </td>


                            <!-- 📝 QUIZ NAME -->

                            <td class="quiz-name">

                                <%= quizName %>

                            </td>


                            <!-- 📚 SUBJECT -->

                            <td>

                                📚 <%= subjectName %>

                            </td>


                            <!-- ⏱️ DURATION -->

                            <td class="duration">

                                ⏱️ <%= timeLimit %> minutes

                            </td>


                            <!-- 🟢 START TIME -->

                            <td class="start-time">

                                🟢
                                <%= startTime.replace(" ", "<br>") %>

                            </td>


                            <!-- 🔴 END TIME -->

                            <td class="end-time">

                                🔴
                                <%= endTime.replace(" ", "<br>") %>

                            </td>


                            <!-- ⚙️ ACTION -->

                            <td class="action-cell">


                                <div class="action-buttons">


                                    <!-- ➕ ADD QUESTIONS -->

                                    <a
                                        href="addQuizQuestion.jsp?quizId=<%= quizId %>"
                                        class="action-button add-button">

                                        ➕ Add Questions

                                    </a>


                                    <!-- 🛠️ MANAGE QUESTIONS -->

                                    <a
                                        href="manageQuestions.jsp?quizId=<%= quizId %>"
                                        class="action-button manage-button">

                                        🛠️ Manage Questions

                                    </a>


                                </div>


                            </td>


                        </tr>


                    <%
                        }
                    %>

                    </tbody>

                </table>


            <%
                }
            %>

        </div>


        <!-- 🔙 BACK TO DASHBOARD -->

        <div class="back-area">

            <a
                href="adminDashboard.jsp"
                class="back-button">

                🔙 Back to Admin Dashboard

            </a>

        </div>


    </div>


</body>

</html>