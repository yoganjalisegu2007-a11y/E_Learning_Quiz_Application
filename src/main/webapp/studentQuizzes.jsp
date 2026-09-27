<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>

<%
    // 🔐 CHECK STUDENT LOGIN

    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<String[]> quizzes =
        (ArrayList<String[]>) request.getAttribute("quizzes");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>📝 Available Quizzes</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f6f9;
}

/* 🎓 HEADER */

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

.back {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

/* 📦 CONTAINER */

.container {
    width: 90%;
    max-width: 1200px;
    margin: 35px auto;
}

.title {
    color: #0B2D5C;
    margin-bottom: 25px;
}

/* 📝 QUIZ GRID */

.quiz-grid {
    display: grid;
    grid-template-columns:
        repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
}

/* 🎯 QUIZ CARD */

.quiz-card {
    background: white;
    border-radius: 14px;
    padding: 25px;
    box-shadow:
        0 4px 12px rgba(0,0,0,0.10);

    border-top: 5px solid #0B2D5C;
}

.quiz-card h2 {
    color: #0B2D5C;
    margin-top: 0;
}

.info {
    margin: 10px 0;
    color: #555;
    line-height: 1.6;
}

.status {
    display: inline-block;
    padding: 7px 12px;
    border-radius: 20px;
    font-weight: bold;
    margin: 10px 0;
}

.available {
    background: #d9f7df;
    color: #176b2c;
}

.upcoming {
    background: #fff3cd;
    color: #856404;
}

.closed {
    background: #f8d7da;
    color: #842029;
}

/* ▶️ START BUTTON */

.start-button {
    display: inline-block;
    margin-top: 15px;
    padding: 11px 22px;
    background: #0B2D5C;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
}

.start-button:hover {
    background: #071F40;
}

/* 📭 EMPTY */

.empty {
    background: white;
    padding: 45px;
    text-align: center;
    border-radius: 14px;
    color: #777;
}

</style>

</head>

<body>

<!-- 🎓 HEADER -->

<div class="header">

    <h1>
        🎓 E-Learning Quiz Application
    </h1>

    <a href="studentDashboard.jsp"
       class="back">
        🏠 Dashboard
    </a>

</div>


<!-- 📋 MAIN -->

<div class="container">

    <h1 class="title">
        📝 Available Quizzes
    </h1>


<%
    if (quizzes != null && !quizzes.isEmpty()) {
%>

    <div class="quiz-grid">

<%
        for (String[] quiz : quizzes) {

            int quizId =
                Integer.parseInt(quiz[0]);

            String quizName =
                quiz[1];

            String subjectName =
                quiz[2];

            String timeLimit =
                quiz[3];

            Timestamp startTime =
                Timestamp.valueOf(quiz[4]);

            Timestamp endTime =
                Timestamp.valueOf(quiz[5]);

            Timestamp now =
                new Timestamp(
                    System.currentTimeMillis());

            boolean upcoming =
                now.before(startTime);

            boolean available =
                !now.before(startTime)
                && now.before(endTime);

            boolean closed =
                !now.before(endTime);
%>

        <!-- 📝 QUIZ CARD -->

        <div class="quiz-card">

            <h2>
                📝 <%= quizName %>
            </h2>

            <div class="info">

                📚 <strong>Subject:</strong>
                <%= subjectName %>

                <br>

                ⏱️ <strong>Duration:</strong>
                <%= timeLimit %> minutes

                <br>

                🟢 <strong>Opens:</strong>
                <%= startTime %>

                <br>

                🔴 <strong>Deadline:</strong>
                <%= endTime %>

            </div>


<%
            if (upcoming) {
%>

                <div class="status upcoming">
                    🟡 Upcoming
                </div>

                <p>
                    ⏰ This quiz has not opened yet.
                </p>

<%
            } else if (available) {
%>

                <div class="status available">
                    🟢 Available
                </div>

                <br>

                <a href="QuizServlet?quizId=<%= quizId %>"
                   class="start-button">

                    ▶️ Start Quiz

                </a>

<%
            } else if (closed) {
%>

                <div class="status closed">
                    🔴 Closed
                </div>

                <p>
                    ⏰ The deadline for this quiz has passed.
                </p>

<%
            }
%>

        </div>

<%
        }
%>

    </div>

<%
    } else {
%>

    <div class="empty">

        <h2>📭 No Quizzes Available</h2>

        <p>
            There are currently no quizzes
            created by the administrator.
        </p>

    </div>

<%
    }
%>

</div>

</body>

</html>