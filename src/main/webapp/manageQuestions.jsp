<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="e_learning.DBConnection" %>

<%
    // 🔐 CHECK ADMIN LOGIN

    String adminUsername =
            (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }


    // 🆔 GET QUIZ ID

    String quizIdText =
            request.getParameter("quizId");

    if (quizIdText == null ||
        quizIdText.trim().isEmpty()) {

        response.sendRedirect("ManageQuizzesServlet");
        return;
    }

    int quizId =
            Integer.parseInt(quizIdText);


    // 📚 QUIZ DETAILS

    String quizName = "";
    String subjectName = "";

    String quizSql =
            "SELECT q.quiz_name, s.subject_name " +
            "FROM quizzes q " +
            "JOIN subjects s " +
            "ON q.subject_id = s.id " +
            "WHERE q.id = ?";


    try {

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(quizSql);

        ps.setInt(1, quizId);

        ResultSet rs =
                ps.executeQuery();

        if (rs.next()) {

            quizName =
                    rs.getString("quiz_name");

            subjectName =
                    rs.getString("subject_name");

        } else {

            rs.close();
            ps.close();
            con.close();

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        rs.close();
        ps.close();
        con.close();


    } catch (Exception e) {

        e.printStackTrace();

%>

        <h2>❌ Error Loading Quiz</h2>

        <p>
            <%= e.getMessage() %>
        </p>

<%
        return;
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>
        🛠️ Manage Questions
    </title>

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

            font-size: 36px;
        }


        /* 📦 CONTAINER */

        .container {

            width: 94%;

            max-width: 1300px;

            margin: 35px auto;
        }


        /* 📚 QUIZ INFORMATION */

        .quiz-info {

            background: white;

            padding: 25px;

            border-radius: 12px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.10);

            margin-bottom: 25px;

            border-left: 6px solid #0B2D5C;
        }


        .quiz-info h2 {

            margin-top: 0;

            color: #0B2D5C;
        }


        .quiz-info p {

            margin: 8px 0;

            font-size: 16px;
        }


        /* 🔘 TOP BUTTONS */

        .top-actions {

            display: flex;

            flex-wrap: wrap;

            gap: 15px;

            margin-bottom: 25px;
        }


        .top-button {

            display: inline-block;

            padding: 12px 20px;

            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: bold;

            transition: 0.3s;
        }


        .add-button {

            background: #0B2D5C;
        }


        .add-button:hover {

            background: #071F40;

            transform: translateY(-2px);
        }


        .back-button {

            background: #555;
        }


        .back-button:hover {

            background: #333;

            transform: translateY(-2px);
        }


        /* 🔍 SEARCH */

        .search-box {

            background: white;

            padding: 20px;

            border-radius: 12px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.08);

            margin-bottom: 25px;
        }


        .search-form {

            display: flex;

            gap: 12px;

            flex-wrap: wrap;
        }


        .search-input {

            flex: 1;

            min-width: 250px;

            padding: 12px;

            border: 1px solid #ccc;

            border-radius: 6px;

            font-size: 15px;
        }


        .search-button {

            padding: 12px 22px;

            border: none;

            background: #0B2D5C;

            color: white;

            border-radius: 6px;

            font-weight: bold;

            cursor: pointer;
        }


        .search-button:hover {

            background: #071F40;
        }


        /* 📝 TITLE */

        .section-title {

            color: #0B2D5C;

            font-size: 28px;

            margin-bottom: 20px;
        }


        /* 📋 QUESTION CARD */

        .question-card {

            background: white;

            border-radius: 12px;

            padding: 25px;

            margin-bottom: 20px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.10);

            border-left: 5px solid #0B2D5C;
        }


        .question-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

            margin-bottom: 15px;

            flex-wrap: wrap;
        }


        .question-number {

            font-size: 18px;

            font-weight: bold;

            color: #0B2D5C;
        }


        .difficulty {

            padding: 6px 12px;

            border-radius: 20px;

            background: #e8eef7;

            color: #0B2D5C;

            font-size: 13px;

            font-weight: bold;
        }


        .question-text {

            font-size: 18px;

            font-weight: bold;

            margin-bottom: 18px;

            line-height: 1.5;
        }


        /* 🔤 OPTIONS */

        .options {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 12px;

            margin-bottom: 20px;
        }


        .option {

            background: #f7f9fc;

            padding: 12px 15px;

            border-radius: 7px;

            border: 1px solid #e1e5eb;

        }


        .correct-option {

            border: 2px solid #0B2D5C;

            background: #e8eef7;

            font-weight: bold;
        }


        /* ⚙️ ACTION BUTTONS */

        .question-actions {

            display: flex;

            gap: 15px;

            flex-wrap: wrap;

            padding-top: 15px;

            border-top: 1px solid #eee;
        }


        .question-button {

            display: inline-block;

            min-width: 130px;

            padding: 11px 18px;

            text-align: center;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;

            transition: 0.3s;
        }


        /* ✏️ EDIT */

        .edit-button {

            background: #0B2D5C;
        }


        .edit-button:hover {

            background: #071F40;

            transform: translateY(-2px);
        }


        /* 🗑️ DELETE */

        .delete-button {

            background: #b42318;
        }


        .delete-button:hover {

            background: #8f1c13;

            transform: translateY(-2px);
        }


        /* 📭 NO QUESTIONS */

        .no-questions {

            background: white;

            padding: 50px;

            text-align: center;

            border-radius: 12px;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.10);

            font-size: 18px;

            color: #777;
        }


        /* 📱 MOBILE */

        @media (max-width: 700px) {

            .header h1 {

                font-size: 28px;
            }


            .container {

                width: 94%;
            }


            .options {

                grid-template-columns: 1fr;
            }


            .question-actions {

                flex-direction: column;
            }


            .question-button {

                width: 100%;
            }
        }

    </style>

</head>


<body>


    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>
            🛠️ Manage Questions
        </h1>

    </div>


    <div class="container">


        <!-- 📚 QUIZ INFORMATION -->

        <div class="quiz-info">

            <h2>
                📝 <%= quizName %>
            </h2>

            <p>
                📚 <strong>Subject:</strong>
                <%= subjectName %>
            </p>

            <p>
                🆔 <strong>Quiz ID:</strong>
                <%= quizId %>
            </p>

        </div>


        <!-- 🔘 TOP ACTIONS -->

        <div class="top-actions">

            <a
                href="addQuizQuestion.jsp?quizId=<%= quizId %>"
                class="top-button add-button">

                ➕ Add Question

            </a>


            <a
                href="ManageQuizzesServlet"
                class="top-button back-button">

                🔙 Back to Manage Quizzes

            </a>

        </div>


        <!-- 🔍 SEARCH -->

        <div class="search-box">

            <form
                action="AdminSearchQuestionServlet"
                method="get"
                class="search-form">


                <input
                    type="hidden"
                    name="quizId"
                    value="<%= quizId %>">


                <input
                    type="text"
                    name="search"
                    class="search-input"
                    placeholder="🔍 Search question..."
                    required>


                <button
                    type="submit"
                    class="search-button">

                    🔍 Search

                </button>

            </form>

        </div>


        <!-- 📝 SECTION TITLE -->

        <div class="section-title">

            ❓ Questions in this Quiz

        </div>


        <%

            boolean hasQuestions = false;

            String questionSql =
                    "SELECT id, question, option_a, option_b, " +
                    "option_c, option_d, correct_answer, difficulty " +
                    "FROM questions " +
                    "WHERE quiz_id = ? " +
                    "ORDER BY id";

            try {

                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(questionSql);

                ps.setInt(1, quizId);

                ResultSet rs =
                        ps.executeQuery();


                while (rs.next()) {

                    hasQuestions = true;

                    int questionId =
                            rs.getInt("id");

                    String question =
                            rs.getString("question");

                    String optionA =
                            rs.getString("option_a");

                    String optionB =
                            rs.getString("option_b");

                    String optionC =
                            rs.getString("option_c");

                    String optionD =
                            rs.getString("option_d");

                    String correctAnswer =
                            rs.getString("correct_answer");

                    String difficulty =
                            rs.getString("difficulty");

        %>


        <!-- 📝 QUESTION CARD -->

        <div class="question-card">


            <div class="question-header">

                <div class="question-number">

                    ❓ Question ID:
                    <%= questionId %>

                </div>


                <div class="difficulty">

                    🎯 <%= difficulty %>

                </div>

            </div>


            <div class="question-text">

                <%= question %>

            </div>


            <!-- 🔤 OPTIONS -->

            <div class="options">


                <div class="option
                    <%= "A".equalsIgnoreCase(correctAnswer)
                        ? "correct-option" : "" %>">

                    <strong>A.</strong>
                    <%= optionA %>

                </div>


                <div class="option
                    <%= "B".equalsIgnoreCase(correctAnswer)
                        ? "correct-option" : "" %>">

                    <strong>B.</strong>
                    <%= optionB %>

                </div>


                <div class="option
                    <%= "C".equalsIgnoreCase(correctAnswer)
                        ? "correct-option" : "" %>">

                    <strong>C.</strong>
                    <%= optionC %>

                </div>


                <div class="option
                    <%= "D".equalsIgnoreCase(correctAnswer)
                        ? "correct-option" : "" %>">

                    <strong>D.</strong>
                    <%= optionD %>

                </div>


            </div>


            <!-- ⚙️ QUESTION ACTIONS -->

            <div class="question-actions">


                <!-- ✏️ EDIT -->

                <a
                    href="EditQuestionServlet?id=<%= questionId %>"
                    class="question-button edit-button">

                    ✏️ Edit Question

                </a>


                <!-- 🗑️ DELETE -->

                <a
                    href="DeleteQuestionServlet?id=<%= questionId %>&quizId=<%= quizId %>"
                    class="question-button delete-button"
                    onclick="return confirm('⚠️ Are you sure you want to delete this question?');">

                    🗑️ Delete Question

                </a>


            </div>


        </div>


        <%

                }

                rs.close();

                ps.close();

                con.close();


            } catch (Exception e) {

                e.printStackTrace();

        %>


            <div class="no-questions">

                ❌ Error loading questions.

                <br><br>

                <%= e.getMessage() %>

            </div>


        <%

                return;
            }


            if (!hasQuestions) {

        %>


            <div class="no-questions">

                📭 No questions have been added
                to this quiz yet.

                <br><br>

                Click
                <strong>➕ Add Question</strong>
                to add the first question.

            </div>


        <%

            }

        %>


    </div>


</body>

</html>