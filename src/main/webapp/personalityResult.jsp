<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String q1 = request.getParameter("q1");
    String q2 = request.getParameter("q2");
    String q3 = request.getParameter("q3");
    String q4 = request.getParameter("q4");
    String q5 = request.getParameter("q5");

    int score = 0;

    if (q1 != null) score += Integer.parseInt(q1);
    if (q2 != null) score += Integer.parseInt(q2);
    if (q3 != null) score += Integer.parseInt(q3);
    if (q4 != null) score += Integer.parseInt(q4);
    if (q5 != null) score += Integer.parseInt(q5);

    String result;
    String description;
    String emoji;

    if (score >= 21) {

        result = "Excellent Learner";
        emoji = "🌟";

        description =
            "You show strong curiosity, responsibility, "
            + "teamwork and confidence in learning.";

    } else if (score >= 16) {

        result = "Active Learner";
        emoji = "🚀";

        description =
            "You have a positive learning attitude "
            + "and enjoy developing new skills.";

    } else if (score >= 11) {

        result = "Balanced Learner";
        emoji = "⚖️";

        description =
            "You have a balanced approach to learning "
            + "and can improve through regular practice.";

    } else {

        result = "Developing Learner";
        emoji = "🌱";

        description =
            "You have opportunities to develop your "
            + "confidence, consistency and learning habits.";
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>🧠 Personality Result</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f7fb;
}

.header {
    background: #0B2D5C;
    color: white;
    text-align: center;
    padding: 30px;
}

.container {
    width: 85%;
    max-width: 700px;
    margin: 50px auto;
}

.result-card {
    background: white;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
}

.result-emoji {
    font-size: 60px;
}

.result-title {
    color: #0B2D5C;
    font-size: 30px;
    margin: 15px;
}

.score {
    font-size: 20px;
    margin: 20px;
}

.description {
    font-size: 17px;
    line-height: 1.6;
}

.back-button {
    display: inline-block;
    margin-top: 25px;
    padding: 13px 25px;
    background: #0B2D5C;
    color: white;
    text-decoration: none;
    border-radius: 8px;
}

.back-button:hover {
    background: #071F40;
}

</style>

</head>

<body>

<div class="header">

    <h1>🧠 Personality Test Result</h1>

    <p>Your educational self-reflection result</p>

</div>


<div class="container">

<div class="result-card">

    <div class="result-emoji">
        <%= emoji %>
    </div>

    <h2 class="result-title">
        <%= result %>
    </h2>

    <div class="score">
        📊 Your Score:
        <strong><%= score %> / 25</strong>
    </div>

    <p class="description">
        <%= description %>
    </p>

    <p>
        💡 This result is for educational
        self-reflection only.
    </p>

   <a
    href="<%= request.getContextPath() %>/dashboard.jsp"
    class="back-button">

    🏠 Back to Dashboard

</a>

</div>

</div>

</body>

</html>