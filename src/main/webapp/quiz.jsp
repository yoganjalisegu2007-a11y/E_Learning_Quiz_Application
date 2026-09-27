<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%

    // 📝 GET QUESTIONS
    @SuppressWarnings("unchecked")

    ArrayList<String[]> questions =
        (ArrayList<String[]>) request.getAttribute("questions");


    // 🆔 GET QUIZ DETAILS
    Integer quizId =
        (Integer) request.getAttribute("quizId");

    String quizName =
        (String) request.getAttribute("quizName");

    String subjectName =
        (String) request.getAttribute("subjectName");


    // ⏱️ GET ADMIN-DEFINED TIME LIMIT
    Integer timeLimit =
        (Integer) request.getAttribute("timeLimit");


    // 🔐 CHECK STUDENT LOGIN
    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>📝 E-Learn Quiz</title>

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
                0 3px 15px rgba(0,0,0,0.12);
        }

        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .container {
            width: 900px;
            max-width: 92%;
            margin: 35px auto;
        }

        .quiz-header {
            background:
                linear-gradient(
                    135deg,
                    #0B2D5C,
                    #164A7A
                );

            color: white;

            padding: 30px;

            border-radius: 18px;

            margin-bottom: 25px;

            box-shadow:
                0 12px 30px
                rgba(11,45,92,0.20);

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;
        }

        .quiz-header-content {
            flex: 1;
        }

        .quiz-header h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .quiz-header p {
            font-size: 14px;

            color:
                rgba(255,255,255,0.90);

            line-height: 1.6;
        }

        .quiz-details {
            margin-top: 12px;
            font-size: 14px;
        }

        .student-thinking {
            width: 110px;
            height: 110px;

            flex-shrink: 0;

            background:
                rgba(255,255,255,0.15);

            border-radius: 50%;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 52px;

            box-shadow:
                0 5px 15px
                rgba(0,0,0,0.15);
        }

        .timer-box {
            background: white;

            padding: 18px;

            border-radius: 15px;

            margin-bottom: 20px;

            text-align: center;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.07);

            border-left:
                5px solid #0B2D5C;
        }

        .timer-title {
            color: #555;

            font-size: 15px;

            margin-bottom: 8px;
        }

        #timer {
            color: #0B2D5C;

            font-size: 30px;

            font-weight: bold;
        }

        .progress-box {
            background: white;

            padding: 18px;

            border-radius: 15px;

            margin-bottom: 25px;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.07);
        }

        .progress-text {
            display: flex;

            justify-content:
                space-between;

            margin-bottom: 10px;

            color: #555;

            font-size: 14px;

            font-weight: bold;
        }

        .progress-container {
            width: 100%;

            height: 10px;

            background: #eeeeee;

            border-radius: 10px;

            overflow: hidden;
        }

        .progress-bar {
            height: 100%;

            width: 0%;

            background: #0B2D5C;

            border-radius: 10px;

            transition: width 0.3s;
        }

        .question-card {
            background: white;

            padding: 28px;

            margin-bottom: 20px;

            border-radius: 18px;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.07);

            border-left:
                4px solid #0B2D5C;
        }

        .question-number {
            color: #0B2D5C;

            font-size: 13px;

            font-weight: bold;

            margin-bottom: 10px;
        }

        .question {
            color: #2d3436;

            font-size: 18px;

            font-weight: bold;

            line-height: 1.5;

            margin-bottom: 20px;
        }

        .difficulty {
            display: inline-block;

            margin-left: 10px;

            padding: 5px 10px;

            border-radius: 8px;

            background: #e8eef7;

            color: #0B2D5C;

            font-size: 12px;

            font-weight: bold;
        }

        .option {
            margin-bottom: 12px;
        }

        .option label {
            display: block;

            padding: 14px 16px;

            border:
                2px solid #eeeeee;

            border-radius: 12px;

            cursor: pointer;

            color: #555;

            font-size: 14px;

            transition: 0.2s;
        }

        .option label:hover {
            border-color: #0B2D5C;

            background: #f4f7fb;

            color: #0B2D5C;
        }

        .option input {
            margin-right: 10px;

            accent-color: #0B2D5C;
        }

        .submit-area {
            text-align: center;

            margin: 30px 0 50px;
        }

        .submit-btn {
            border: none;

            padding: 15px 45px;

            border-radius: 12px;

            background: #0B2D5C;

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 10px 25px
                rgba(11,45,92,0.30);
        }

        .no-questions {
            background: white;

            padding: 40px;

            border-radius: 18px;

            text-align: center;

            color: #777;

            box-shadow:
                0 6px 20px
                rgba(0,0,0,0.07);
        }

        .no-questions .emoji {
            font-size: 55px;

            margin-bottom: 15px;
        }

        .no-questions h2 {
            color: #333;

            margin-bottom: 10px;
        }

        @media (max-width: 650px) {

            .header {
                padding: 0 20px;
            }

            .container {
                max-width: 94%;
            }

            .quiz-header {
                padding: 25px;

                flex-direction: column;

                text-align: center;
            }

            .quiz-header h1 {
                font-size: 25px;
            }

            .student-thinking {
                width: 85px;
                height: 85px;

                font-size: 42px;
            }

            .question-card {
                padding: 22px;
            }
        }

    </style>

</head>

<body>


<div class="header">

    <div class="logo">
        🧠 E-LEARN
    </div>

</div>


<div class="container">


    <div class="quiz-header">

        <div class="quiz-header-content">

            <h1>
                📝 <%= quizName %>
            </h1>

            <p>
                💭 Think carefully, choose your answers,
                and complete the quiz before time runs out.
            </p>

            <div class="quiz-details">

                📚 Subject:
                <strong>
                    <%= subjectName %>
                </strong>

                &nbsp;&nbsp; | &nbsp;&nbsp;

                ⏱️ Duration:
                <strong>
                    <%= timeLimit %> minutes
                </strong>

            </div>

        </div>


        <div class="student-thinking">
            🧑‍💻🤔
        </div>

    </div>


<%

    if (questions != null &&
        !questions.isEmpty()) {

%>


    <!-- ⏱️ TIMER -->

    <div class="timer-box">

        <div class="timer-title">
            ⏱️ Time Remaining
        </div>

        <div id="timer">
            Loading...
        </div>

    </div>


    <!-- 📊 PROGRESS -->

    <div class="progress-box">

        <div class="progress-text">

            <span id="progressText">

                0 /
                <%= questions.size() %>
                Answered

            </span>

            <span>
                📊 Progress
            </span>

        </div>


        <div class="progress-container">

            <div
                id="progressBar"
                class="progress-bar">
            </div>

        </div>

    </div>


    <!-- 📝 QUIZ FORM -->

    <form
        id="quizForm"
        action="SubmitQuizServlet"
        method="post">


        <!-- 🆔 SEND QUIZ ID -->

        <input
            type="hidden"
            name="quizId"
            value="<%= quizId %>">


<%

        int questionNumber = 1;

        for (int i = 0;
             i < questions.size();
             i++) {

            String[] q =
                questions.get(i);

%>


        <div class="question-card">


            <div class="question-number">

                ❓ Question
                <%= questionNumber %>
                of
                <%= questions.size() %>

            </div>


            <div class="question">

                <%= q[1] %>

                <span class="difficulty">

                    🎯 <%= q[6] %>

                </span>

            </div>


            <div class="option">

                <label>

                    <input
                        type="radio"
                        name="answer_<%= q[0] %>"
                        value="A"
                        onchange="updateProgress()">

                    🅰️ <%= q[2] %>

                </label>

            </div>


            <div class="option">

                <label>

                    <input
                        type="radio"
                        name="answer_<%= q[0] %>"
                        value="B"
                        onchange="updateProgress()">

                    🅱️ <%= q[3] %>

                </label>

            </div>


            <div class="option">

                <label>

                    <input
                        type="radio"
                        name="answer_<%= q[0] %>"
                        value="C"
                        onchange="updateProgress()">

                    ©️ <%= q[4] %>

                </label>

            </div>


            <div class="option">

                <label>

                    <input
                        type="radio"
                        name="answer_<%= q[0] %>"
                        value="D"
                        onchange="updateProgress()">

                    🅳 <%= q[5] %>

                </label>

            </div>


        </div>


<%

            questionNumber++;

        }

%>


        <div class="submit-area">

            <button
                type="submit"
                class="submit-btn">

                📝 Submit Quiz

            </button>

        </div>


    </form>


<%

    } else {

%>


    <div class="no-questions">

        <div class="emoji">
            🤔
        </div>

        <h2>
            No Questions Available
        </h2>

        <p>
            📝 There are currently no questions
            for this quiz.
        </p>

    </div>


<%

    }

%>


</div>


<script>

    // =========================================
    // 📊 UPDATE PROGRESS
    // =========================================

    function updateProgress() {

        const totalQuestions =
            <%= questions != null
                ? questions.size()
                : 0 %>;


        const selectedAnswers =
            document.querySelectorAll(
                'input[type="radio"]:checked'
            ).length;


        const percentage =
            totalQuestions > 0
            ? (selectedAnswers /
               totalQuestions) * 100
            : 0;


        const progressBar =
            document.getElementById(
                "progressBar");


        const progressText =
            document.getElementById(
                "progressText");


        if (progressBar) {

            progressBar.style.width =
                percentage + "%";

        }


        if (progressText) {

            progressText.textContent =
                selectedAnswers +
                " / " +
                totalQuestions +
                " Answered";

        }

    }


    // =========================================
    // ⏱️ ADMIN-CONTROLLED TIMER
    // =========================================

    let timeLeft =
        <%= timeLimit != null
            ? timeLimit * 60
            : 0 %>;


    const timer =
        document.getElementById(
            "timer");


    const quizForm =
        document.getElementById(
            "quizForm");


    let timerInterval;


    function updateTimer() {

        let minutes =
            Math.floor(
                timeLeft / 60);


        let seconds =
            timeLeft % 60;


        minutes =
            minutes
                .toString()
                .padStart(2, "0");


        seconds =
            seconds
                .toString()
                .padStart(2, "0");


        if (timer) {

            timer.textContent =
                minutes +
                ":" +
                seconds;

        }


        // 🔴 TIME OVER

        if (timeLeft <= 0) {

            clearInterval(
                timerInterval);


            alert(
                "⏰ Time is over! " +
                "Your quiz will be submitted automatically."
            );


            if (quizForm) {

                quizForm.submit();

            }

            return;
        }


        timeLeft--;

    }


    // 🚀 START TIMER

    if (timer &&
        quizForm &&
        <%= timeLimit != null
            ? timeLimit
            : 0 %> > 0) {

        updateTimer();

        timerInterval =
            setInterval(
                updateTimer,
                1000);

    }


</script>


</body>

</html>