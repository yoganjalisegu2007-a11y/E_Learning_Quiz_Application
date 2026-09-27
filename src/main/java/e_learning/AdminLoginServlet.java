package e_learning;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "text/html;charset=UTF-8");

        PrintWriter out =
                response.getWriter();

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String sql =
                "SELECT * FROM admin " +
                "WHERE username = ? AND password = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                // 🔐 Create admin session

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "adminId",
                        rs.getInt("id"));

                session.setAttribute(
                        "adminUsername",
                        rs.getString("username"));

                response.sendRedirect(
                        "adminDashboard.jsp");

            } else {

                // ❌ Invalid login

                out.println("<html>");

                out.println("<head>");

                out.println(
                        "<meta charset='UTF-8'>");

                out.println(
                        "<title>❌ Admin Login Failed</title>");

                out.println("<style>");

                out.println(
                        "body {" +
                        "font-family:Arial,sans-serif;" +
                        "background:#f4f6f9;" +
                        "display:flex;" +
                        "justify-content:center;" +
                        "align-items:center;" +
                        "height:100vh;" +
                        "margin:0;" +
                        "}"
                );

                out.println(
                        ".box {" +
                        "background:white;" +
                        "padding:35px;" +
                        "border-radius:14px;" +
                        "box-shadow:0 4px 15px rgba(0,0,0,0.12);" +
                        "text-align:center;" +
                        "}"
                );

                out.println(
                        "h2 {" +
                        "color:#c0392b;" +
                        "}"
                );

                out.println(
                        "p {" +
                        "color:#666;" +
                        "}"
                );

                out.println(
                        "a {" +
                        "display:inline-block;" +
                        "margin-top:15px;" +
                        "padding:11px 22px;" +
                        "background:#0B2D5C;" +
                        "color:white;" +
                        "text-decoration:none;" +
                        "border-radius:6px;" +
                        "font-weight:bold;" +
                        "}"
                );

                out.println(
                        "a:hover {" +
                        "background:#071F40;" +
                        "}"
                );

                out.println("</style>");

                out.println("</head>");

                out.println("<body>");

                out.println(
                        "<div class='box'>");

                out.println(
                        "<h2>❌ Admin Login Failed</h2>");

                out.println(
                        "<p>Invalid username or password.</p>");

                out.println(
                        "<a href='adminLogin.jsp'>" +
                        "🔐 Try Again" +
                        "</a>"
                );

                out.println("</div>");

                out.println("</body>");

                out.println("</html>");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            out.println("<html>");

            out.println("<head>");

            out.println(
                    "<meta charset='UTF-8'>");

            out.println(
                    "<title>⚠️ Admin Login Error</title>");

            out.println("</head>");

            out.println("<body>");

            out.println(
                    "<h2>⚠️ Admin Login Error</h2>"
            );

            out.println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );

            out.println("</body>");

            out.println("</html>");
        }
    }
}