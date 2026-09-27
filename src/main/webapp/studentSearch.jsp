<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 🔐 Check student login

    if (session.getAttribute("studentId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>🔍 Search Questions</title>

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

            color: white;

            padding: 20px 45px;

            box-shadow:
                0 3px 12px
                rgba(0,0,0,0.12);
        }

        .logo {
            font-size: 24px;

            font-weight: bold;

            letter-spacing: 2px;
        }

        .container {
            width: 750px;

            max-width: 92%;

            margin: 50px auto;

            background: white;

            padding: 40px;

            border-radius: 18px;

            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.10);
        }

        .search-icon {
            width: 75px;

            height: 75px;

            margin: 0 auto 20px;

            border-radius: 50%;

            background: #e8eef7;

            color: #0B2D5C;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 32px;
        }

        .title-section {
            text-align: center;

            margin-bottom: 30px;
        }

        .title-section h1 {
            color: #2d3436;

            margin-bottom: 10px;

            font-size: 30px;
        }

        .title-section p {
            color: #777;

            font-size: 14px;

            line-height: 1.6;
        }

        .search-form {
            display: flex;

            gap: 10px;

            margin-top: 25px;
        }

        .search-form input {
            flex: 1;

            padding: 14px 16px;

            border:
                2px solid #e1e5eb;

            border-radius: 8px;

            outline: none;

            font-size: 15px;

            background: #fafafa;

            transition: 0.3s;
        }

        .search-form input:focus {
            border-color: #0B2D5C;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(11,45,92,0.08);
        }

        .search-form button {
            padding: 14px 24px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-size: 14px;

            font-weight: bold;

            transition: 0.3s;
        }

        .search-form button:hover {
            background: #071F40;

            transform:
                translateY(-2px);

            box-shadow:
                0 7px 15px
                rgba(11,45,92,0.20);
        }

        .result {
            margin-top: 30px;

            padding: 22px;

            background: #f4f6f9;

            border-left:
                5px solid #0B2D5C;

            border-radius: 8px;

            color: #444;

            line-height: 1.7;
        }

        .result-title {
            color: #0B2D5C;

            font-weight: bold;

            margin-bottom: 10px;
        }

        .back {
            display: block;

            width: fit-content;

            margin: 30px auto 0;

            padding: 11px 22px;

            background: #e8eef7;

            color: #0B2D5C;

            text-decoration: none;

            border-radius: 7px;

            font-size: 14px;

            font-weight: bold;

            transition: 0.3s;
        }

        .back:hover {
            background: #d6e0ef;

            transform:
                translateY(-2px);
        }

        .hint {
            margin-top: 20px;

            text-align: center;

            color: #999;

            font-size: 12px;
        }

        @media (max-width: 600px) {

            .container {
                padding: 30px 20px;
            }

            .title-section h1 {
                font-size: 25px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-form button {
                width: 100%;
            }

        }

    </style>

</head>

<body>


<!-- 🔷 Header -->

<div class="header">

    <div class="logo">

        🎓 E-LEARN

    </div>

</div>


<div class="container">


    <!-- 🔍 Search Icon -->

    <div class="search-icon">

        🔍

    </div>


    <!-- 📚 Title -->

    <div class="title-section">

        <h1>

            🔍 Search Questions

        </h1>

        <p>

            Search the question bank using a keyword
            to quickly find a question. 📚

        </p>

    </div>


    <!-- 🔎 Search Form -->

    <form
        action="SearchQuestionServlet"
        method="get"
        class="search-form">


        <input
            type="text"
            name="keyword"
            placeholder="🔎 Enter question keyword"
            required>


        <button type="submit">

            🔍 Search

        </button>


    </form>


    <%

        String result =
            (String) request.getAttribute("result");


        if (result != null) {

    %>


        <!-- 📋 Search Result -->

        <div class="result">

            <div class="result-title">

                📋 Search Result

            </div>

            <%= result %>

        </div>


    <%

        }

    %>


    <!-- 💡 Hint -->

    <div class="hint">

        💡 Enter a word or phrase related to the question.

    </div>


    <!-- 🏠 Back -->

    <a
        href="dashboard.jsp"
        class="back">

        🏠 Back to Dashboard

    </a>


</div>


</body>

</html>