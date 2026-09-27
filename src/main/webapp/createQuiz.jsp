<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>📝 Create Quiz - E-Learn</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f7fb;
    color: #222;
}

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
    font-size: 25px;
}

.header a {
    color: white;
    text-decoration: none;
    background: #071F40;
    padding: 10px 18px;
    border-radius: 6px;
}

.container {
    width: 600px;
    max-width: 90%;
    margin: 40px auto;
}

.card {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.card h2 {
    color: #0B2D5C;
    margin-top: 0;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
}

input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
}

button {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 6px;
    background: #0B2D5C;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background: #071F40;
}

.info {
    background: #eef4fb;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.error {
    color: #b00020;
    margin-bottom: 15px;
}

.success {
    color: green;
    margin-bottom: 15px;
}

</style>

</head>

<body>

<div class="header">

    <h1>🧑‍💼 E-Learn Admin</h1>

    <a href="adminDashboard.jsp">
        🏠 Dashboard
    </a>

</div>


<div class="container">

<div class="card">

    <h2>📝 Create New Quiz</h2>

    <div class="info">

        📚 Select the subject for this quiz.

        <br><br>

        ⏱️ Set how long students can take the quiz.

        <br><br>

        🟢 Set when the quiz opens.

        <br>

        🔴 Set when the quiz closes.

    </div>


    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if ("invalid".equals(error)) {
    %>

        <div class="error">
            ❌ Please enter valid quiz details.
        </div>

    <%
        }

        if ("time".equals(error)) {
    %>

        <div class="error">
            ❌ End time must be after start time.
        </div>

    <%
        }

        if ("created".equals(success)) {
    %>

        <div class="success">
            ✅ Quiz created successfully!
        </div>

    <%
        }
    %>


    <form action="CreateQuizServlet" method="post">


        <div class="form-group">

            <label>
                📚 Subject ID
            </label>

            <input
                type="number"
                name="subjectId"
                placeholder="Enter Subject ID"
                required>

        </div>


        <div class="form-group">

            <label>
                📝 Quiz Name
            </label>

            <input
                type="text"
                name="quizName"
                placeholder="Example: Java Unit 1 Quiz"
                required>

        </div>


        <div class="form-group">

            <label>
                ⏱️ Time Limit (minutes)
            </label>

            <input
                type="number"
                name="timeLimit"
                min="1"
                placeholder="Example: 30"
                required>

        </div>


        <div class="form-group">

            <label>
                🟢 Quiz Open Date & Time
            </label>

            <input
                type="datetime-local"
                name="startTime"
                required>

        </div>


        <div class="form-group">

            <label>
                🔴 Quiz Close Date & Time
            </label>

            <input
                type="datetime-local"
                name="endTime"
                required>

        </div>


        <button type="submit">
            🚀 Create Quiz
        </button>

    </form>

</div>

</div>

</body>

</html>