<%@ page session="true" %>

<%
    Integer studentId =
            (Integer) session.getAttribute("studentId");

    if (studentId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String subjectId =
            request.getParameter("subjectId");

    if (subjectId == null || subjectId.isEmpty()) {
        response.sendRedirect("selectSubject.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Select Difficulty</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #eef4ff;
        }

        .header {
            background: #4b3f8f;
            color: white;
            padding: 25px 40px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 60px auto;
        }

        .box {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        h2 {
            color: #4b3f8f;
            margin-top: 0;
        }

        p {
            color: #555;
            line-height: 1.6;
        }

        label {
            display: block;
            margin-top: 25px;
            margin-bottom: 8px;
            font-weight: bold;
        }

        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #cccccc;
            border-radius: 8px;
            font-size: 16px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            background: #4b3f8f;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #392f72;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #4b3f8f;
            text-decoration: none;
        }

    </style>

</head>

<body>


<div class="header">

    <h1>
        E-Learning Quiz Application
    </h1>

</div>


<div class="container">

    <div class="box">

        <h2>
            Select Difficulty
        </h2>

        <p>
            Choose the difficulty level for your quiz.
        </p>


        <form
            action="QuizServlet"
            method="get"
        >

            <input
                type="hidden"
                name="subjectId"
                value="<%= subjectId %>"
            >


            <label>
                Difficulty Level
            </label>


            <select
                name="difficulty"
                required
            >

                <option value="">
                    Select Difficulty
                </option>

                <option value="Easy">
                    Easy
                </option>

                <option value="Medium">
                    Medium
                </option>

                <option value="Hard">
                    Hard
                </option>

            </select>


            <button type="submit">
                Start Quiz
            </button>

        </form>


        <a
            href="selectSubject.jsp"
            class="back"
        >
            Back to Subject Selection
        </a>

    </div>

</div>


</body>

</html>