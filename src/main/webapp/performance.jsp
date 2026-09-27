<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 🔐 Check student login

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }

    int totalQuizzes =
        (Integer) request.getAttribute("totalQuizzes");

    int totalQuestions =
        (Integer) request.getAttribute("totalQuestions");

    double averageScore =
        (Double) request.getAttribute("averageScore");

    double averagePercentage =
        (Double) request.getAttribute("averagePercentage");

    int highestScore =
        (Integer) request.getAttribute("highestScore");

    double latestPercentage =
        (Double) request.getAttribute("latestPercentage");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>📊 Performance Analysis</title>

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
        }

        .title-section {
            text-align: center;

            margin-bottom: 35px;
        }

        .performance-icon {
            width: 75px;

            height: 75px;

            margin: 0 auto 15px;

            border-radius: 50%;

            background: #e8eef7;

            color: #0B2D5C;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 32px;
        }

        h1 {
            color: #2d3436;

            margin-bottom: 8px;

            font-size: 30px;
        }

        .subtitle {
            color: #777;

            font-size: 14px;
        }

        .cards {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 22px;
        }

        .card {
            background: white;

            padding: 28px 20px;

            border-radius: 14px;

            text-align: center;

            box-shadow:
                0 5px 15px
                rgba(0,0,0,0.09);

            border-top:
                4px solid #0B2D5C;

            transition: 0.3s;
        }

        .card:hover {
            transform:
                translateY(-5px);

            box-shadow:
                0 9px 20px
                rgba(0,0,0,0.13);
        }

        .card h2 {
            margin: 0;

            color: #555;

            font-size: 17px;

            font-weight: bold;
        }

        .value {
            margin-top: 15px;

            font-size: 30px;

            font-weight: bold;

            color: #0B2D5C;
        }

        .buttons {
            text-align: center;

            margin-top: 35px;
        }

        .buttons a {
            display: inline-block;

            padding: 12px 22px;

            margin: 5px;

            background: #0B2D5C;

            color: white;

            text-decoration: none;

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

        @media (max-width: 600px) {

            .header {
                padding: 18px 25px;
            }

            .container {
                width: 94%;
            }

            h1 {
                font-size: 25px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>


<!-- 🔷 Header -->

<div class="header">

    <div class="logo">

        🎓 E-LEARN

    </div>

</div>


<div class="container">


    <!-- 📊 Title -->

    <div class="title-section">

        <div class="performance-icon">

            📊

        </div>

        <h1>

            📊 My Performance Analysis

        </h1>

        <p class="subtitle">

            📈 Track your quiz progress and learning performance

        </p>

    </div>


    <!-- 📊 Performance Cards -->

    <div class="cards">


        <!-- 📝 Total Quizzes -->

        <div class="card">

            <h2>

                📝 Total Quizzes

            </h2>

            <div class="value">

                <%= totalQuizzes %>

            </div>

        </div>


        <!-- ❓ Total Questions -->

        <div class="card">

            <h2>

                ❓ Total Questions Attempted

            </h2>

            <div class="value">

                <%= totalQuestions %>

            </div>

        </div>


        <!-- 🎯 Average Score -->

        <div class="card">

            <h2>

                🎯 Average Score

            </h2>

            <div class="value">

                <%= String.format("%.2f", averageScore) %>

            </div>

        </div>


        <!-- 📈 Average Percentage -->

        <div class="card">

            <h2>

                📈 Average Percentage

            </h2>

            <div class="value">

                <%= String.format("%.2f", averagePercentage) %>%

            </div>

        </div>


        <!-- 🏆 Highest Score -->

        <div class="card">

            <h2>

                🏆 Highest Score

            </h2>

            <div class="value">

                <%= highestScore %>

            </div>

        </div>


        <!-- ⚡ Latest Quiz -->

        <div class="card">

            <h2>

                ⚡ Latest Quiz Percentage

            </h2>

            <div class="value">

                <%= String.format("%.2f", latestPercentage) %>%

            </div>

        </div>


    </div>


    <!-- 🔘 Buttons -->

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