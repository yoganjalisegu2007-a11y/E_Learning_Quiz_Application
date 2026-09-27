<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>🧠 Personality Test - E-Learn</title>

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

        /* 🔵 HEADER */

        .header {
            background: #0B2D5C;
            color: white;
            text-align: center;
            padding: 20px;
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .header p {
            margin: 8px 0 0;
            font-size: 15px;
        }

        /* 🧠 MAIN CONTAINER */

        .container {
            width: 90%;
            max-width: 900px;
            margin: 30px auto;
        }

        /* 🖼️ PERSONALITY IMAGE */

        .image-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .personality-image {
            width: 100%;
            max-width: 800px;
            height: 280px;
            object-fit: cover;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.20);
        }

        /* 📋 TEST CARD */

        .test-card {
            background: white;
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.10);
        }

        .test-title {
            text-align: center;
            color: #0B2D5C;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .description {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        /* ❓ QUESTION */

        .question {
            background: #f8faff;
            border-left: 5px solid #0B2D5C;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .question h3 {
            color: #0B2D5C;
            margin-top: 0;
            margin-bottom: 15px;
        }

        /* 🔘 OPTIONS */

        .option {
            display: block;
            background: white;
            border: 1px solid #ddd;
            padding: 12px;
            margin: 8px 0;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }

        .option:hover {
            background: #eef4ff;
            border-color: #0B2D5C;
        }

        .option input {
            margin-right: 8px;
        }

        /* 🧠 SUBMIT */

        .submit-container {
            text-align: center;
            margin-top: 30px;
        }

        .submit-button {
            border: none;
            background: #0B2D5C;
            color: white;
            padding: 14px 30px;
            border-radius: 8px;
            font-size: 17px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-button:hover {
            background: #071F40;
        }

        /* 🏠 BACK */

        .back-container {
            text-align: center;
            margin-top: 20px;
        }

        .back-button {
            display: inline-block;
            text-decoration: none;
            background: #0B2D5C;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .back-button:hover {
            background: #071F40;
        }

        /* 📱 MOBILE */

        @media (max-width: 600px) {

            .container {
                width: 94%;
            }

            .test-card {
                padding: 18px;
            }

            .personality-image {
                height: 200px;
            }

            .question {
                padding: 15px;
            }

        }

    </style>

</head>

<body>


    <!-- 🔵 HEADER -->

    <div class="header">

        <h1>🧠 Personality Test</h1>

        <p>
            🌟 Discover your learning personality and traits
        </p>

    </div>


    <!-- 🧠 MAIN -->

    <div class="container">


        <!-- 🖼️ PERSONALITY IMAGE -->

        <div class="image-container">

            <img
                src="<%= request.getContextPath() %>/images/personality.png"
                alt="🧠 Personality Test"
                class="personality-image">

        </div>


        <!-- 📋 TEST -->

        <div class="test-card">

            <h2 class="test-title">
                🧠 Student Personality Test
            </h2>

            <p class="description">

                Answer the following questions honestly.
                Choose the option that best describes you. 😊

            </p>


            <form
                action="<%= request.getContextPath() %>/personalityResult.jsp"
                method="post">


                <!-- ❓ QUESTION 1 -->

                <div class="question">

                    <h3>
                        1️⃣ I enjoy working with other people.
                    </h3>

                    <label class="option">
                        <input
                            type="radio"
                            name="q1"
                            value="5"
                            required>
                        ⭐ Strongly Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q1"
                            value="4">
                        👍 Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q1"
                            value="3">
                        😐 Neutral
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q1"
                            value="2">
                        👎 Disagree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q1"
                            value="1">
                        ❌ Strongly Disagree
                    </label>

                </div>


                <!-- ❓ QUESTION 2 -->

                <div class="question">

                    <h3>
                        2️⃣ I enjoy solving new and challenging problems.
                    </h3>

                    <label class="option">
                        <input
                            type="radio"
                            name="q2"
                            value="5"
                            required>
                        ⭐ Strongly Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q2"
                            value="4">
                        👍 Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q2"
                            value="3">
                        😐 Neutral
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q2"
                            value="2">
                        👎 Disagree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q2"
                            value="1">
                        ❌ Strongly Disagree
                    </label>

                </div>


                <!-- ❓ QUESTION 3 -->

                <div class="question">

                    <h3>
                        3️⃣ I complete my work on time.
                    </h3>

                    <label class="option">
                        <input
                            type="radio"
                            name="q3"
                            value="5"
                            required>
                        ⭐ Strongly Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q3"
                            value="4">
                        👍 Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q3"
                            value="3">
                        😐 Neutral
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q3"
                            value="2">
                        👎 Disagree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q3"
                            value="1">
                        ❌ Strongly Disagree
                    </label>

                </div>


                <!-- ❓ QUESTION 4 -->

                <div class="question">

                    <h3>
                        4️⃣ I like learning new technologies.
                    </h3>

                    <label class="option">
                        <input
                            type="radio"
                            name="q4"
                            value="5"
                            required>
                        ⭐ Strongly Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q4"
                            value="4">
                        👍 Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q4"
                            value="3">
                        😐 Neutral
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q4"
                            value="2">
                        👎 Disagree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q4"
                            value="1">
                        ❌ Strongly Disagree
                    </label>

                </div>


                <!-- ❓ QUESTION 5 -->

                <div class="question">

                    <h3>
                        5️⃣ I stay calm when facing difficult tasks.
                    </h3>

                    <label class="option">
                        <input
                            type="radio"
                            name="q5"
                            value="5"
                            required>
                        ⭐ Strongly Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q5"
                            value="4">
                        👍 Agree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q5"
                            value="3">
                        😐 Neutral
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q5"
                            value="2">
                        👎 Disagree
                    </label>

                    <label class="option">
                        <input
                            type="radio"
                            name="q5"
                            value="1">
                        ❌ Strongly Disagree
                    </label>

                </div>


                <!-- 🧠 SUBMIT -->

                <div class="submit-container">

                    <button
                        type="submit"
                        class="submit-button">

                        🧠 See My Result

                    </button>

                </div>

            </form>


            <!-- 🏠 BACK -->

            <div class="back-container">

                <a
                    href="<%= request.getContextPath() %>/dashboard.jsp"
                    class="back-button">

                    🏠 Back to Dashboard

                </a>

            </div>

        </div>

    </div>

</body>

</html>