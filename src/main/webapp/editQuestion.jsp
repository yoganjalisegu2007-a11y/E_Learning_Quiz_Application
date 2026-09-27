<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 🔐 CHECK ADMIN LOGIN

    String adminUsername =
            (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }


    // 🆔 GET QUESTION DETAILS

    Object questionIdObj =
            request.getAttribute("questionId");

    Object quizIdObj =
            request.getAttribute("quizId");

    Object subjectIdObj =
            request.getAttribute("subjectId");


    if (questionIdObj == null ||
        quizIdObj == null ||
        subjectIdObj == null) {

        response.sendRedirect(
                "ManageQuizzesServlet");

        return;
    }


    int questionId =
            (Integer) questionIdObj;

    int quizId =
            (Integer) quizIdObj;

    int subjectId =
            (Integer) subjectIdObj;


    String question =
            (String) request.getAttribute("question");

    String optionA =
            (String) request.getAttribute("optionA");

    String optionB =
            (String) request.getAttribute("optionB");

    String optionC =
            (String) request.getAttribute("optionC");

    String optionD =
            (String) request.getAttribute("optionD");

    String correctAnswer =
            (String) request.getAttribute("correctAnswer");

    String difficulty =
            (String) request.getAttribute("difficulty");


    if (question == null) {
        question = "";
    }

    if (optionA == null) {
        optionA = "";
    }

    if (optionB == null) {
        optionB = "";
    }

    if (optionC == null) {
        optionC = "";
    }

    if (optionD == null) {
        optionD = "";
    }

    if (correctAnswer == null) {
        correctAnswer = "A";
    }

    if (difficulty == null) {
        difficulty = "Easy";
    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>✏️ Edit Question</title>

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

            font-size: 34px;
        }


        /* 📦 CONTAINER */

        .container {

            width: 90%;

            max-width: 900px;

            margin: 35px auto;
        }


        /* 📝 EDIT BOX */

        .edit-box {

            background: white;

            padding: 35px;

            border-radius: 14px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.10);

            border-top: 5px solid #0B2D5C;
        }


        .edit-box h2 {

            margin-top: 0;

            color: #0B2D5C;

            margin-bottom: 25px;
        }


        /* ℹ️ QUIZ INFO */

        .quiz-info {

            background: #e8eef7;

            padding: 18px;

            border-radius: 8px;

            margin-bottom: 25px;

            line-height: 1.7;
        }


        /* 🏷️ LABEL */

        label {

            display: block;

            margin-top: 20px;

            margin-bottom: 8px;

            font-weight: bold;

            color: #0B2D5C;
        }


        /* 📝 TEXTAREA */

        textarea {

            width: 100%;

            min-height: 110px;

            padding: 13px;

            border: 1px solid #ccc;

            border-radius: 7px;

            font-family: Arial, sans-serif;

            font-size: 15px;

            resize: vertical;
        }


        /* 🔤 INPUT */

        input[type="text"] {

            width: 100%;

            padding: 13px;

            border: 1px solid #ccc;

            border-radius: 7px;

            font-size: 15px;
        }


        /* 🎯 SELECT */

        select {

            width: 100%;

            padding: 13px;

            border: 1px solid #ccc;

            border-radius: 7px;

            font-size: 15px;

            background: white;
        }


        /* 🔘 BUTTON AREA */

        .buttons {

            display: flex;

            gap: 15px;

            margin-top: 30px;

            flex-wrap: wrap;
        }


        /* 💾 UPDATE */

        .update-button {

            flex: 1;

            min-width: 200px;

            padding: 14px;

            border: none;

            border-radius: 7px;

            background: #0B2D5C;

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }


        .update-button:hover {

            background: #071F40;

            transform: translateY(-2px);
        }


        /* 🔙 CANCEL */

        .cancel-button {

            flex: 1;

            min-width: 200px;

            padding: 14px;

            border-radius: 7px;

            background: #555;

            color: white;

            text-decoration: none;

            text-align: center;

            font-weight: bold;

            transition: 0.3s;
        }


        .cancel-button:hover {

            background: #333;

            transform: translateY(-2px);
        }


        /* 📱 MOBILE */

        @media (max-width: 700px) {

            .container {

                width: 94%;
            }

            .edit-box {

                padding: 22px;
            }

            .header h1 {

                font-size: 27px;
            }

            .buttons {

                flex-direction: column;
            }

        }

    </style>

</head>


<body>


    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>
            ✏️ Edit Question
        </h1>

    </div>


    <div class="container">


        <div class="edit-box">


            <h2>
                🛠️ Modify Question
            </h2>


            <!-- ℹ️ QUIZ INFORMATION -->

            <div class="quiz-info">

                🆔 <strong>Question ID:</strong>
                <%= questionId %>

                <br>

                📝 <strong>Quiz ID:</strong>
                <%= quizId %>

                <br>

                📚 <strong>Subject ID:</strong>
                <%= subjectId %>

            </div>


            <!-- 📝 EDIT FORM -->

            <form
                action="EditQuestionServlet"
                method="post">


                <!-- 🆔 HIDDEN QUESTION ID -->

                <input
                    type="hidden"
                    name="questionId"
                    value="<%= questionId %>">


                <!-- 📝 HIDDEN QUIZ ID -->

                <input
                    type="hidden"
                    name="quizId"
                    value="<%= quizId %>">


                <!-- 📚 HIDDEN SUBJECT ID -->

                <input
                    type="hidden"
                    name="subjectId"
                    value="<%= subjectId %>">


                <!-- ❓ QUESTION -->

                <label>
                    ❓ Question
                </label>

                <textarea
                    name="question"
                    required><%= question %></textarea>


                <!-- 🅰️ OPTION A -->

                <label>
                    🅰️ Option A
                </label>

                <input
                    type="text"
                    name="optionA"
                    value="<%= optionA %>"
                    required>


                <!-- 🅱️ OPTION B -->

                <label>
                    🅱️ Option B
                </label>

                <input
                    type="text"
                    name="optionB"
                    value="<%= optionB %>"
                    required>


                <!-- ©️ OPTION C -->

                <label>
                    ©️ Option C
                </label>

                <input
                    type="text"
                    name="optionC"
                    value="<%= optionC %>"
                    required>


                <!-- 🅳 OPTION D -->

                <label>
                    🅳 Option D
                </label>

                <input
                    type="text"
                    name="optionD"
                    value="<%= optionD %>"
                    required>


                <!-- ✅ CORRECT ANSWER -->

                <label>
                    ✅ Correct Answer
                </label>

                <select
                    name="correctAnswer"
                    required>

                    <option
                        value="A"
                        <%= "A".equalsIgnoreCase(correctAnswer)
                            ? "selected" : "" %>>

                        A

                    </option>

                    <option
                        value="B"
                        <%= "B".equalsIgnoreCase(correctAnswer)
                            ? "selected" : "" %>>

                        B

                    </option>

                    <option
                        value="C"
                        <%= "C".equalsIgnoreCase(correctAnswer)
                            ? "selected" : "" %>>

                        C

                    </option>

                    <option
                        value="D"
                        <%= "D".equalsIgnoreCase(correctAnswer)
                            ? "selected" : "" %>>

                        D

                    </option>

                </select>


                <!-- 🎯 DIFFICULTY -->

                <label>
                    🎯 Difficulty
                </label>

                <select
                    name="difficulty"
                    required>

                    <option
                        value="Easy"
                        <%= "Easy".equalsIgnoreCase(difficulty)
                            ? "selected" : "" %>>

                        🟢 Easy

                    </option>

                    <option
                        value="Medium"
                        <%= "Medium".equalsIgnoreCase(difficulty)
                            ? "selected" : "" %>>

                        🟡 Medium

                    </option>

                    <option
                        value="Hard"
                        <%= "Hard".equalsIgnoreCase(difficulty)
                            ? "selected" : "" %>>

                        🔴 Hard

                    </option>

                </select>


                <!-- 🔘 BUTTONS -->

                <div class="buttons">


                    <!-- 💾 UPDATE -->

                    <button
                        type="submit"
                        class="update-button">

                        💾 Update Question

                    </button>


                    <!-- 🔙 CANCEL -->

                    <a
                        href="manageQuestions.jsp?quizId=<%= quizId %>"
                        class="cancel-button">

                        🔙 Cancel

                    </a>


                </div>


            </form>


        </div>


    </div>


</body>

</html>