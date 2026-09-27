<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>🔐 Admin Login</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;

            min-height: 100vh;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 400px;
            max-width: 90%;

            background: white;

            padding: 35px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.10);
        }

        .admin-icon {
            text-align: center;

            font-size: 45px;

            margin-bottom: 10px;
        }

        h1 {
            text-align: center;

            color: #0B2D5C;

            margin-bottom: 25px;
        }

        label {
            display: block;

            margin-top: 15px;

            margin-bottom: 5px;

            color: #333;

            font-weight: bold;
        }

        input {
            width: 100%;

            padding: 12px;

            border: 1px solid #cccccc;

            border-radius: 8px;

            font-size: 14px;
        }

        input:focus {
            outline: none;

            border-color: #0B2D5C;

            box-shadow:
                0 0 0 2px rgba(11, 45, 92, 0.10);
        }

        button {
            width: 100%;

            margin-top: 25px;

            padding: 12px;

            background: #0B2D5C;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;

            font-size: 16px;

            font-weight: bold;

            transition: 0.3s;
        }

        button:hover {
            background: #071F40;

            transform: translateY(-2px);
        }

        .back {
            text-align: center;

            margin-top: 20px;
        }

        .back a {
            color: #0B2D5C;

            text-decoration: none;

            font-weight: bold;
        }

        .back a:hover {
            text-decoration: underline;
        }

        .security {
            text-align: center;

            margin-top: 20px;

            color: #777;

            font-size: 13px;
        }

        @media (max-width: 500px) {

            .container {
                padding: 25px;
            }

            h1 {
                font-size: 24px;
            }

        }

    </style>

</head>

<body>

    <div class="container">

        <div class="admin-icon">
            🛡️
        </div>

        <h1>
            🔐 Admin Login
        </h1>

        <form action="AdminLoginServlet" method="post">

            <label>
                👤 Username
            </label>

            <input
                type="text"
                name="username"
                placeholder="Enter admin username"
                required>

            <label>
                🔑 Password
            </label>

            <input
                type="password"
                name="password"
                placeholder="Enter admin password"
                required>

            <button type="submit">
                🚀 Login as Admin
            </button>

        </form>

        <div class="back">

            <a href="login.jsp">
                ↩️ Back to Student Login
            </a>

        </div>

        <div class="security">
            🔒 Admin access is restricted.
        </div>

    </div>

</body>

</html>