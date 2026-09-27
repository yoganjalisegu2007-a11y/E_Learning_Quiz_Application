<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>🔐 E-Learn Quiz - Login</title>

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

            background:
                linear-gradient(
                    120deg,
                    #dce6f5,
                    #f4f6f9
                );

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 25px;
        }

        .card {
            width: 1000px;
            max-width: 100%;

            min-height: 620px;

            background: white;

            border-radius: 30px;

            display: flex;

            overflow: hidden;

            box-shadow:
                0 25px 60px
                rgba(0, 0, 0, 0.20);
        }

        /* 🧑‍🎓 LEFT SECTION */

        .left {
            width: 48%;

            background:
                linear-gradient(
                    160deg,
                    #0B2D5C,
                    #164A7A
                );

            color: white;

            padding: 35px;

            display: flex;

            flex-direction: column;

            justify-content: center;

            align-items: center;

            text-align: center;
        }

        .student-image {
            width: 230px;
            height: 300px;

            object-fit: cover;

            border-radius: 22px;

            border: 5px solid
                rgba(255, 255, 255, 0.9);

            box-shadow:
                0 15px 35px
                rgba(0, 0, 0, 0.30);

            margin-bottom: 25px;
        }

        .logo {
            font-size: 25px;

            font-weight: bold;

            letter-spacing: 2px;

            margin-bottom: 12px;
        }

        .left h1 {
            font-size: 32px;

            line-height: 1.15;

            margin-bottom: 12px;
        }

        .left h1 span {
            color: #9ec5f5;
        }

        .left p {
            font-size: 14px;

            line-height: 1.7;

            color:
                rgba(255, 255, 255, 0.90);

            max-width: 360px;
        }

        /* 🔐 RIGHT SECTION */

        .right {
            width: 52%;

            padding: 50px 65px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }

        .welcome {
            color: #0B2D5C;

            font-size: 14px;

            font-weight: bold;

            margin-bottom: 8px;
        }

        .right h2 {
            color: #2d3436;

            font-size: 32px;

            margin-bottom: 8px;
        }

        .subtitle {
            color: #888;

            font-size: 14px;

            margin-bottom: 30px;
        }

        .input-box {
            margin-bottom: 20px;
        }

        .input-box label {
            display: block;

            color: #444;

            font-size: 13px;

            font-weight: bold;

            margin-bottom: 7px;
        }

        .input-field input {
            width: 100%;

            height: 50px;

            padding: 0 15px;

            border:
                2px solid #eeeeee;

            border-radius: 12px;

            outline: none;

            background: #fafafa;

            font-size: 14px;

            transition: 0.3s;
        }

        .input-field input:focus {
            border-color: #0B2D5C;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(11, 45, 92, 0.10);
        }

        .login-btn {
            width: 100%;

            height: 52px;

            margin-top: 8px;

            border: none;

            border-radius: 13px;

            background: #0B2D5C;

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }

        .login-btn:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 10px 25px
                rgba(11, 45, 92, 0.30);
        }

        .register {
            text-align: center;

            margin-top: 23px;

            color: #888;

            font-size: 14px;
        }

        .register a {
            color: #0B2D5C;

            font-weight: bold;

            text-decoration: none;
        }

        .register a:hover {
            text-decoration: underline;
        }

        .secure {
            text-align: center;

            margin-top: 20px;

            color: #aaa;

            font-size: 11px;
        }

        /* 📱 MOBILE */

        @media (max-width: 800px) {

            .card {
                width: 100%;
            }

            .left {
                display: none;
            }

            .right {
                width: 100%;

                padding: 45px 30px;
            }
        }

    </style>

</head>

<body>

    <div class="card">

        <!-- 🧑‍🎓 LEFT STUDENT SECTION -->

        <div class="left">

            <!-- 📸 Student Image -->

            <img
    src="${pageContext.request.contextPath}/images/student-login.png"
    alt="🎓 Student Learning"
    class="student-image">

            <div class="logo">
                🎓 E-LEARN
            </div>

            <h1>

                Welcome<br>

                <span>
                    Back.
                </span>

            </h1>

            <p>

                📚 Continue your learning journey.

                Practice programming concepts,
                take quizzes and improve your skills.

            </p>

        </div>


        <!-- 🔐 RIGHT LOGIN SECTION -->

        <div class="right">

            <div class="welcome">
                👋 Welcome Back!
            </div>

            <h2>
                🔐 Login to Your Account
            </h2>

            <p class="subtitle">

                Enter your details to continue learning.

            </p>


            <!-- 📧 LOGIN FORM -->

            <form
                action="LoginServlet"
                method="post">


                <!-- 📧 EMAIL -->

                <div class="input-box">

                    <label>
                        📧 Email Address
                    </label>

                    <div class="input-field">

                        <input
                            type="email"
                            name="email"
                            placeholder="Enter your email address"
                            required>

                    </div>

                </div>


                <!-- 🔑 PASSWORD -->

                <div class="input-box">

                    <label>
                        🔑 Password
                    </label>

                    <div class="input-field">

                        <input
                            type="password"
                            name="password"
                            placeholder="Enter your password"
                            required>

                    </div>

                </div>


                <!-- 🚀 LOGIN BUTTON -->

                <button
                    type="submit"
                    class="login-btn">

                    🚀 Login to E-Learn

                </button>

            </form>


            <!-- 📝 REGISTER -->

            <div class="register">

                Don't have an account?

                <a href="register.jsp">

                    📝 Register here

                </a>

            </div>


            <!-- 🔒 SECURITY -->

            <div class="secure">

                🔒 Your account information is protected.

            </div>

        </div>

    </div>

</body>

</html>