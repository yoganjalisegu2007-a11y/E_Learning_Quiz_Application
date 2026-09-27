<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

    <title>🛠️ Admin Dashboard</title>

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
        }

        /* 🔵 HEADER */

        .header {
            background: #0B2D5C;
            color: white;

            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .admin-info {
            font-size: 15px;
        }

        /* 📦 CONTAINER */

        .container {
            width: 90%;
            max-width: 1200px;

            margin: 35px auto;
        }

        /* 👋 WELCOME */

        .welcome-box {
            background: white;

            padding: 30px;

            border-radius: 16px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.10);

            margin-bottom: 30px;

            border-left: 6px solid #0B2D5C;
        }

        .welcome-box h2 {
            color: #0B2D5C;
            margin-top: 0;
        }

        .welcome-box p {
            color: #555;

            font-size: 16px;

            line-height: 1.6;
        }

        /* 🃏 DASHBOARD CARDS */

        .cards {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(260px, 1fr));

            gap: 25px;
        }

        .card {
            background: white;

            padding: 28px 25px;

            border-radius: 14px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.10);

            border-top: 4px solid #0B2D5C;

            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-6px);

            box-shadow:
                0 8px 20px rgba(0,0,0,0.15);
        }

        .card-icon {
            width: 60px;
            height: 60px;

            margin-bottom: 18px;

            border-radius: 50%;

            background: #e8eef7;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 28px;
        }

        .card h2 {
            color: #333;

            margin-top: 0;

            font-size: 21px;
        }

        .card p {
            color: #666;

            line-height: 1.5;

            min-height: 45px;
        }

        /* 🔘 BUTTON */

        .dashboard-button {
            display: inline-block;

            margin-top: 15px;

            padding: 11px 22px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;

            transition: 0.3s;
        }

        .dashboard-button:hover {
            background: #071F40;

            transform: translateY(-2px);
        }

        /* 🚪 LOGOUT */

        .logout-area {
            text-align: center;

            margin-top: 35px;
        }

        .logout {
            display: inline-block;

            padding: 11px 25px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;

            transition: 0.3s;
        }

        .logout:hover {
            background: #071F40;

            transform: translateY(-2px);
        }

        /* 🎓 FOOTER */

        .footer {
            text-align: center;

            margin-top: 40px;

            padding: 20px;

            color: #777;

            font-size: 13px;
        }

        /* 📱 MOBILE */

        @media (max-width: 700px) {

            .header {
                padding: 18px 20px;

                flex-direction: column;

                gap: 8px;

                text-align: center;
            }

            .header h1 {
                font-size: 21px;
            }

            .container {
                width: 92%;
            }

        }

    </style>

</head>


<body>


    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>
            🛠️ E-Learning Quiz Administration
        </h1>

        <div class="admin-info">

            👤 Admin:

            <strong>
                <%= adminUsername %>
            </strong>

        </div>

    </div>


    <div class="container">


        <!-- 👋 WELCOME -->

        <div class="welcome-box">

            <h2>
                👋 Welcome, <%= adminUsername %>!
            </h2>

            <p>
                Welcome to the E-Learning Quiz Application
                administration panel.
            </p>

            <p>
                📝 From here, you can create quizzes,
                schedule quizzes, add questions,
                manage syllabus, students and results.
            </p>

        </div>


        <!-- 🃏 DASHBOARD CARDS -->

        <div class="cards">


            <!-- 📚 MANAGE SUBJECTS -->

            <div class="card">

                <div class="card-icon">
                    📚
                </div>

                <h2>
                    Manage Subjects
                </h2>

                <p>
                    Add and manage quiz subjects
                    for the application.
                </p>

                <a
                    href="manageSubjects.jsp"
                    class="dashboard-button">

                    📚 Manage Subjects

                </a>

            </div>


            <!-- 📝 CREATE QUIZ -->

            <div class="card">

                <div class="card-icon">
                    📝
                </div>

                <h2>
                    Create Quiz
                </h2>

                <p>
                    Create a particular quiz with
                    duration, open time and closing time.
                </p>

                <a
                    href="createQuiz.jsp"
                    class="dashboard-button">

                    📝 Create Quiz

                </a>

            </div>


            <!-- 📋 MANAGE QUIZZES -->

            <div class="card">

                <div class="card-icon">
                    📋
                </div>

                <h2>
                    Manage Quizzes
                </h2>

                <p>
                    View created quizzes and add
                    questions to each particular quiz.
                </p>

                <a
                    href="ManageQuizzesServlet"
                    class="dashboard-button">

                    📋 Manage Quizzes

                </a>

            </div>


            <!-- 📖 MANAGE SYLLABUS -->

            <div class="card">

                <div class="card-icon">
                    📖
                </div>

                <h2>
                    Manage Syllabus
                </h2>

                <p>
                    Add and manage subject-wise
                    learning syllabus.
                </p>

                <a
                    href="manageSyllabus.jsp"
                    class="dashboard-button">

                    📖 Manage Syllabus

                </a>

            </div>


            <!-- 👨‍🎓 VIEW STUDENTS -->

            <div class="card">

                <div class="card-icon">
                    👨‍🎓
                </div>

                <h2>
                    View Students
                </h2>

                <p>
                    View students registered
                    in the application.
                </p>

                <a
                    href="ViewStudentsServlet"
                    class="dashboard-button">

                    👨‍🎓 View Students

                </a>

            </div>


            <!-- 📊 QUIZ RESULTS -->

            <div class="card">

                <div class="card-icon">
                    📊
                </div>

                <h2>
                    Quiz Results
                </h2>

                <p>
                    View student quiz scores,
                    percentages and results.
                </p>

                <a
                    href="AdminResultsServlet"
                    class="dashboard-button">

                    📊 View Results

                </a>

            </div>


        </div>


        <!-- 🚪 LOGOUT -->

        <div class="logout-area">

            <a
                href="AdminLogoutServlet"
                class="logout">

                🚪 Logout

            </a>

        </div>


        <!-- 🎓 FOOTER -->

        <div class="footer">

            <p>
                🎓 E-Learning Quiz Application
            </p>

        </div>


    </div>

</body>

</html>