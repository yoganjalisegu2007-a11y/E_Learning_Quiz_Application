<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="e_learning.DBConnection" %>

<%

    // 🔐 CHECK STUDENT LOGIN

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    String studentName =
            (String) session.getAttribute("studentName");

    if (studentName == null) {
        studentName = "Student";
    }

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>🎓 Student Dashboard</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background: #f4f7fb;
    color: #222;
}

/* 🔵 HEADER */

.header {
    background: #0B2D5C;
    color: white;
    padding: 18px 40px;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 26px;
    font-weight: bold;
}

.welcome {
    font-size: 16px;
}

/* 🎓 HERO */

.hero {
    background:
        linear-gradient(
            rgba(11,45,92,0.85),
            rgba(11,45,92,0.85)
        ),
        url("images/student-learning.jpg");

    background-size: cover;
    background-position: center;

    height: 260px;

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    color: white;
    text-align: center;
}

.hero h1 {
    font-size: 38px;
    margin-bottom: 12px;
}

.hero p {
    font-size: 18px;
}

/* 📝 QUIZZES SECTION */

.quiz-section {
    padding: 35px 50px;
}

.section-title {
    text-align: center;
    color: #0B2D5C;
    margin-bottom: 25px;
    font-size: 30px;
}

.quiz-container {
    display: grid;

    grid-template-columns:
        repeat(auto-fit, minmax(280px, 1fr));

    gap: 25px;
}

.quiz-card {
    background: white;

    border-radius: 12px;

    padding: 25px;

    box-shadow:
        0 4px 12px rgba(0,0,0,0.10);

    border-left: 5px solid #0B2D5C;
}

.quiz-card h3 {
    color: #0B2D5C;
    margin-bottom: 15px;
    font-size: 22px;
}

.quiz-info {
    margin: 9px 0;
    font-size: 15px;
}

.status {
    margin-top: 15px;
    font-weight: bold;
}

.available {
    color: green;
}

.upcoming {
    color: #d68910;
}

.closed {
    color: red;
}

.start-button {
    display: inline-block;

    margin-top: 18px;

    padding: 11px 20px;

    background: #0B2D5C;
    color: white;

    text-decoration: none;

    border-radius: 6px;

    font-weight: bold;
}

.start-button:hover {
    background: #071F40;
}

.no-quizzes {
    text-align: center;

    background: white;

    padding: 30px;

    border-radius: 10px;

    color: #555;

    box-shadow:
        0 3px 10px rgba(0,0,0,0.08);
}

/* 📚 DASHBOARD CARDS */

.dashboard {
    padding: 20px 50px 50px;

    display: grid;

    grid-template-columns:
        repeat(auto-fit, minmax(250px, 1fr));

    gap: 25px;
}

.card {
    background: white;

    padding: 30px;

    border-radius: 12px;

    text-align: center;

    box-shadow:
        0 4px 12px rgba(0,0,0,0.10);
}

.card-icon {
    font-size: 45px;
    margin-bottom: 15px;
}

.card h2 {
    color: #0B2D5C;
    margin-bottom: 10px;
}

.card p {
    color: #555;

    margin-bottom: 20px;

    line-height: 1.5;
}

.dashboard-button {
    display: inline-block;

    padding: 11px 20px;

    background: #0B2D5C;
    color: white;

    text-decoration: none;

    border-radius: 6px;

    font-weight: bold;
}

.dashboard-button:hover {
    background: #071F40;
}

/* 🧠 PERSONALITY TEST */

.personality-button {
    background: #0B2D5C;
}

.personality-button:hover {
    background: #071F40;
}

/* 🚪 LOGOUT */

.logout {
    background: #c62828;
}

.logout:hover {
    background: #8e0000;
}

/* 📱 MOBILE */

@media (max-width: 600px) {

    .header {
        padding: 15px 20px;

        flex-direction: column;

        gap: 10px;
    }

    .hero h1 {
        font-size: 28px;
    }

    .quiz-section,
    .dashboard {
        padding-left: 20px;
        padding-right: 20px;
    }

}

</style>

</head>

<body>

<!-- 🔵 HEADER -->

<div class="header">

    <div class="logo">
        🎓 E-LEARN
    </div>

    <div class="welcome">
        👋 Welcome, <%= studentName %>
    </div>

</div>


<!-- 🎓 HERO SECTION -->

<div class="hero">

    <h1>
        🎓 Student Dashboard
    </h1>

    <p>
        📚 Learn • Practice • Test • Improve
    </p>

</div>


<!-- 📝 AVAILABLE QUIZZES -->

<div class="quiz-section">

    <h2 class="section-title">
        📝 Available Quizzes
    </h2>

    <div class="quiz-container">

        <%

            String sql =
                "SELECT q.id, " +
                "q.quiz_name, " +
                "s.subject_name, " +
                "q.time_limit, " +
                "q.start_time, " +
                "q.end_time " +
                "FROM quizzes q " +
                "JOIN subjects s " +
                "ON q.subject_id = s.id " +
                "ORDER BY q.start_time ASC";

            boolean hasQuizzes = false;

            try {

                Connection con =
                    DBConnection.getConnection();

                PreparedStatement ps =
                    con.prepareStatement(sql);

                ResultSet rs =
                    ps.executeQuery();

                Timestamp currentTime =
                    new Timestamp(
                        System.currentTimeMillis()
                    );

                while (rs.next()) {

                    hasQuizzes = true;

                    int quizId =
                        rs.getInt("id");

                    String quizName =
                        rs.getString("quiz_name");

                    String subjectName =
                        rs.getString("subject_name");

                    int timeLimit =
                        rs.getInt("time_limit");

                    Timestamp startTime =
                        rs.getTimestamp("start_time");

                    Timestamp endTime =
                        rs.getTimestamp("end_time");

                    boolean available =
                        !currentTime.before(startTime)
                        &&
                        currentTime.before(endTime);

                    boolean upcoming =
                        currentTime.before(startTime);

                    boolean closed =
                        !currentTime.before(endTime);

        %>

        <!-- 📝 QUIZ CARD -->

        <div class="quiz-card">

            <h3>
                📝 <%= quizName %>
            </h3>

            <div class="quiz-info">

                📚 Subject:
                <strong>
                    <%= subjectName %>
                </strong>

            </div>

            <div class="quiz-info">

                ⏱️ Duration:
                <strong>
                    <%= timeLimit %> minutes
                </strong>

            </div>

            <div class="quiz-info">

                🟢 Opens:
                <strong>
                    <%= startTime %>
                </strong>

            </div>

            <div class="quiz-info">

                🔴 Closes:
                <strong>
                    <%= endTime %>
                </strong>

            </div>


            <% if (available) { %>

                <div class="status available">

                    🟢 Available Now

                </div>

                <a
                    href="<%= request.getContextPath() %>/QuizServlet?quizId=<%= quizId %>"
                    class="start-button">

                    ▶️ Start Quiz

                </a>

            <% } else if (upcoming) { %>

                <div class="status upcoming">

                    🟡 Upcoming

                </div>

            <% } else if (closed) { %>

                <div class="status closed">

                    🔴 Quiz Closed

                </div>

            <% } %>

        </div>

        <%

                }

                rs.close();
                ps.close();
                con.close();

            } catch (Exception e) {

                e.printStackTrace();

        %>

            <div class="no-quizzes">

                ❌ Unable to load quizzes.

                <br><br>

                Please try again later.

            </div>

        <%

            }

            if (!hasQuizzes) {

        %>

            <div class="no-quizzes">

                📭 No quizzes available currently.

                <br><br>

                Please check again later.

            </div>

        <%

            }

        %>

    </div>

</div>


<!-- 📚 OTHER DASHBOARD OPTIONS -->

<div class="dashboard">


    <!-- 📖 SYLLABUS -->

    <div class="card">

        <div class="card-icon">
            📖
        </div>

        <h2>
            View Syllabus
        </h2>

        <p>
            📚 View subjects and syllabus content.
        </p>

        <a
            href="<%= request.getContextPath() %>/viewSyllabus.jsp"
            class="dashboard-button">

            📖 View Syllabus

        </a>

    </div>


    <!-- 🏆 LEADERBOARD -->

    <div class="card">

        <div class="card-icon">
            🏆
        </div>

        <h2>
            Leaderboard
        </h2>

        <p>
            🏆 Check your ranking among students.
        </p>

        <a
            href="<%= request.getContextPath() %>/LeaderboardServlet"
            class="dashboard-button">

            🏆 View Leaderboard

        </a>

    </div>


    <!-- 📈 PERFORMANCE -->

    <div class="card">

        <div class="card-icon">
            📈
        </div>

        <h2>
            My Performance
        </h2>

        <p>
            📊 View your quiz scores and performance.
        </p>

        <a
            href="<%= request.getContextPath() %>/PerformanceServlet"
            class="dashboard-button">

            📈 View Performance

        </a>

    </div>


    <!-- 🔍 SEARCH QUESTION -->

    <div class="card">

        <div class="card-icon">
            🔍
        </div>

        <h2>
            Search Question
        </h2>

        <p>
            🔍 Search questions from the quiz database.
        </p>

        <a
            href="<%= request.getContextPath() %>/studentSearch.jsp"
            class="dashboard-button">

            🔍 Search

        </a>

    </div>


    <!-- 🧠 PERSONALITY TEST -->

    <div class="card">

        <div class="card-icon">
            🧠
        </div>

        <h2>
            Personality Test
        </h2>

        <p>
            🧠 Discover your personality
            and learning traits.
        </p>

        <a
            href="<%= request.getContextPath() %>/personalityTest.jsp"
            class="dashboard-button personality-button">

            🧠 Take Personality Test

        </a>

    </div>


    <!-- 🚪 LOGOUT -->

    <div class="card">

        <div class="card-icon">
            🚪
        </div>

        <h2>
            Logout
        </h2>

        <p>
            🔐 Logout from your student account.
        </p>

        <a
            href="<%= request.getContextPath() %>/LogoutServlet"
            class="dashboard-button logout">

            🚪 Logout

        </a>

    </div>


</div>

</body>

</html>