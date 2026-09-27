<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>➕ Add Quiz Question</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f7fb;
}

.header {
    background: #0B2D5C;
    color: white;
    padding: 20px;
    text-align: center;
}

.container {
    width: 650px;
    max-width: 90%;
    margin: 35px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.12);
}

h2 {
    color: #0B2D5C;
    text-align: center;
}

.quiz-info {
    background: #eef4fb;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 25px;
}

label {
    display: block;
    margin-top: 15px;
    margin-bottom: 6px;
    font-weight: bold;
    color: #0B2D5C;
}

input,
textarea,
select {
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

textarea {
    height: 100px;
    resize: vertical;
}

.button {
    width: 100%;
    margin-top: 25px;
    padding: 12px;
    background: #0B2D5C;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
}

.button:hover {
    background: #071F40;
}

.back {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #0B2D5C;
    text-decoration: none;
}

</style>

</head>

<body>

<div class="header">

    <h1>➕ Add Question</h1>

</div>

<div class="container">

<%

    String quizIdText =
            request.getParameter("quizId");

    if (quizIdText == null || quizIdText.trim().isEmpty()) {

%>

        <h2>❌ Quiz ID Missing</h2>

        <p style="text-align:center;">
            Please return to Manage Quizzes and select a quiz.
        </p>

<%

    } else {

        int quizId =
                Integer.parseInt(quizIdText);

        String quizName = "";
        int subjectId = 0;
        String subjectName = "";

        try {

            Connection con =
                    e_learning.DBConnection.getConnection();

            String sql =
                    "SELECT q.quiz_name, " +
                    "q.subject_id, " +
                    "s.subject_name " +
                    "FROM quizzes q " +
                    "JOIN subjects s " +
                    "ON q.subject_id = s.id " +
                    "WHERE q.id = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, quizId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                quizName =
                        rs.getString("quiz_name");

                subjectId =
                        rs.getInt("subject_id");

                subjectName =
                        rs.getString("subject_name");

%>

                <div class="quiz-info">

                    <strong>📝 Quiz:</strong>
                    <%= quizName %>
                    <br><br>

                    <strong>📚 Subject:</strong>
                    <%= subjectName %>

                </div>

                <form action="AddQuestionServlet"
                      method="post">

                    <!-- 🔑 Hidden Quiz ID -->
                    <input type="hidden"
                           name="quizId"
                           value="<%= quizId %>">

                    <!-- 📚 Hidden Subject ID -->
                    <input type="hidden"
                           name="subjectId"
                           value="<%= subjectId %>">

                    <label>❓ Question</label>

                    <textarea
                        name="question"
                        required></textarea>

                    <label>🅰️ Option A</label>

                    <input type="text"
                           name="optionA"
                           required>

                    <label>🅱️ Option B</label>

                    <input type="text"
                           name="optionB"
                           required>

                    <label>©️ Option C</label>

                    <input type="text"
                           name="optionC"
                           required>

                    <label>🅳 Option D</label>

                    <input type="text"
                           name="optionD"
                           required>

                    <label>✅ Correct Answer</label>

                    <select name="correctAnswer"
                            required>

                        <option value="">
                            -- Select Correct Answer --
                        </option>

                        <option value="A">
                            🅰️ Option A
                        </option>

                        <option value="B">
                            🅱️ Option B
                        </option>

                        <option value="C">
                            ©️ Option C
                        </option>

                        <option value="D">
                            🅳 Option D
                        </option>

                    </select>

                    <label>🎯 Difficulty</label>

                    <select name="difficulty"
                            required>

                        <option value="Easy">
                            🟢 Easy
                        </option>

                        <option value="Medium">
                            🟡 Medium
                        </option>

                        <option value="Hard">
                            🔴 Hard
                        </option>

                    </select>

                    <button type="submit"
                            class="button">

                        ➕ Add Question

                    </button>

                </form>

<%

            } else {

%>

                <h2>❌ Quiz Not Found</h2>

<%

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

%>

            <h2>❌ Database Error</h2>

            <p>
                <%= e.getMessage() %>
            </p>

<%

        }

    }

%>

<a href="ManageQuizzesServlet"
   class="back">

    ⬅️ Back to Manage Quizzes

</a>

</div>

</body>
</html>