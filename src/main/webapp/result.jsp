<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 🔐 Check student login

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<%
    Integer score =
        (Integer) request.getAttribute("score");

    Integer total =
        (Integer) request.getAttribute("total");

    Double percentage =
        (Double) request.getAttribute("percentage");


    // 🛡️ Default values

    if (score == null) {
        score = 0;
    }

    if (total == null) {
        total = 0;
    }

    if (percentage == null) {
        percentage = 0.0;
    }


    // ❌ Calculate wrong/unanswered questions

    int wrong = total - score;
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>🏆 Quiz Result</title>

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

            height: 70px;

            display: flex;

            align-items: center;

            padding: 0 50px;

            box-shadow:
                0 3px 15px
                rgba(0,0,0,0.12);
        }

        .logo {
            color: white;

            font-size: 24px;

            font-weight: bold;

            letter-spacing: 2px;
        }

        .container {
            width: 850px;

            max-width: 92%;

            margin: 45px auto;
        }

        .result-card {
            background: white;

            padding: 45px;

            border-radius: 20px;

            text-align: center;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.10);
        }

        .celebration {
            width: 80px;

            height: 80px;

            margin: 0 auto 20px;

            border-radius: 50%;

            background: #e8eef7;

            color: #0B2D5C;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 35px;
        }

        .result-card h1 {
            color: #2d3436;

            margin-bottom: 10px;

            font-size: 30px;
        }

        .result-card > p {
            color: #777;

            margin-bottom: 25px;
        }

        .score-circle {
            width: 160px;

            height: 160px;

            margin: 20px auto 35px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    #0B2D5C,
                    #164A7A
                );

            color: white;

            display: flex;

            flex-direction: column;

            justify-content: center;

            align-items: center;

            box-shadow:
                0 10px 25px
                rgba(11,45,92,0.25);
        }

        .score-circle .percentage {
            font-size: 32px;

            font-weight: bold;
        }

        .score-circle .label {
            font-size: 13px;

            margin-top: 5px;
        }

        .stats {
            display: flex;

            justify-content: center;

            gap: 20px;

            margin-bottom: 35px;

            flex-wrap: wrap;
        }

        .stat {
            width: 200px;

            padding: 22px;

            border-radius: 15px;

            background: #f4f6f9;

            border-top:
                4px solid #0B2D5C;
        }

        .stat h2 {
            color: #0B2D5C;

            margin-bottom: 7px;

            font-size: 27px;
        }

        .stat p {
            color: #777;

            font-size: 13px;
        }

        .buttons {
            display: flex;

            justify-content: center;

            gap: 15px;

            flex-wrap: wrap;
        }

        .btn {
            text-decoration: none;

            padding: 13px 25px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: bold;

            transition: 0.3s;
        }

        .primary {
            background: #0B2D5C;

            color: white;
        }

        .primary:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 8px 18px
                rgba(11,45,92,0.25);
        }

        .secondary {
            background: #e8eef7;

            color: #0B2D5C;
        }

        .secondary:hover {
            background: #d6e0ef;

            transform:
                translateY(-2px);
        }

        @media (max-width: 700px) {

            .header {
                padding: 0 25px;
            }

            .result-card {
                padding: 30px 20px;
            }

            .stat {
                width: 100%;
            }

            .score-circle {
                width: 140px;

                height: 140px;
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


    <div class="result-card">


        <!-- 🎉 Completion Icon -->

        <div class="celebration">

            🎉

        </div>


        <h1>

            🎉 Quiz Completed!

        </h1>


        <p>

            Great work! Here is your quiz performance. 📊

        </p>


        <!-- 📊 Percentage -->

        <div class="score-circle">

            <div class="percentage">

                <%= String.format("%.2f", percentage) %>%

            </div>

            <div class="label">

                📈 Percentage

            </div>

        </div>


        <!-- 📋 Statistics -->

        <div class="stats">


            <!-- ✅ Correct -->

            <div class="stat">

                <h2>

                    <%= score %>

                </h2>

                <p>

                    ✅ Correct Answers

                </p>

            </div>


            <!-- ❌ Wrong -->

            <div class="stat">

                <h2>

                    <%= wrong %>

                </h2>

                <p>

                    ❌ Wrong / Unanswered

                </p>

            </div>


            <!-- 📝 Total -->

            <div class="stat">

                <h2>

                    <%= total %>

                </h2>

                <p>

                    📝 Total Questions

                </p>

            </div>


        </div>


        <!-- 🔘 Buttons -->

        <div class="buttons">


            <a
                href="selectSubject.jsp"
                class="btn primary">

                📝 Take Another Quiz

            </a>


            <a
                href="dashboard.jsp"
                class="btn secondary">

                🏠 Back to Dashboard

            </a>


        </div>


    </div>

</div>

</body>

</html>