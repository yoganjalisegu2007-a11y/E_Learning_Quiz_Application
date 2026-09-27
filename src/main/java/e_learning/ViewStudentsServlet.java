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

@WebServlet("/ViewStudentsServlet")
public class ViewStudentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "text/html;charset=UTF-8");

        PrintWriter out =
                response.getWriter();

        // =========================================
        // 🔐 CHECK ADMIN LOGIN
        // =========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // =========================================
        // 👨‍🎓 GET STUDENTS
        // =========================================

        String sql =
                "SELECT id, name, email " +
                "FROM students";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            // =========================================
            // 🌐 HTML PAGE
            // =========================================

            out.println("<html>");

            out.println("<head>");

            out.println(
                    "<meta charset='UTF-8'>");

            out.println(
                    "<title>👨‍🎓 View Students</title>");

            out.println("<style>");

            out.println(
                    "body {" +
                    "font-family: Arial, sans-serif;" +
                    "background:#f4f6f9;" +
                    "padding:40px;" +
                    "}"
            );

            out.println(
                    ".box {" +
                    "background:white;" +
                    "padding:30px;" +
                    "max-width:1000px;" +
                    "margin:auto;" +
                    "border-radius:14px;" +
                    "box-shadow:0 4px 12px rgba(0,0,0,0.10);" +
                    "}"
            );

            out.println(
                    "h1 {" +
                    "color:#0B2D5C;" +
                    "text-align:center;" +
                    "margin-bottom:10px;" +
                    "}"
            );

            out.println(
                    ".subtitle {" +
                    "text-align:center;" +
                    "color:#666;" +
                    "margin-bottom:20px;" +
                    "}"
            );

            out.println(
                    "table {" +
                    "width:100%;" +
                    "border-collapse:collapse;" +
                    "margin-top:20px;" +
                    "}"
            );

            out.println(
                    "th, td {" +
                    "padding:14px;" +
                    "border-bottom:1px solid #ddd;" +
                    "text-align:center;" +
                    "}"
            );

            out.println(
                    "th {" +
                    "background:#0B2D5C;" +
                    "color:white;" +
                    "}"
            );

            out.println(
                    "tr:hover {" +
                    "background:#f1f5fa;" +
                    "}"
            );

            out.println(
                    "a {" +
                    "display:inline-block;" +
                    "margin-top:25px;" +
                    "padding:11px 20px;" +
                    "background:#0B2D5C;" +
                    "color:white;" +
                    "text-decoration:none;" +
                    "border-radius:6px;" +
                    "font-weight:bold;" +
                    "transition:0.3s;" +
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
                    "<h1>👨‍🎓 Registered Students</h1>");

            out.println(
                    "<div class='subtitle'>" +
                    "📋 View all students registered in the E-Learning Quiz Application" +
                    "</div>");

            out.println("<table>");

            out.println("<tr>");

            out.println("<th>🆔 ID</th>");

            out.println("<th>👤 Name</th>");

            out.println("<th>📧 Email</th>");

            out.println("</tr>");

            // =========================================
            // 👨‍🎓 DISPLAY STUDENTS
            // =========================================

            while (rs.next()) {

                out.println("<tr>");

                out.println(
                        "<td>" +
                        rs.getInt("id") +
                        "</td>"
                );

                out.println(
                        "<td>👤 " +
                        rs.getString("name") +
                        "</td>"
                );

                out.println(
                        "<td>📧 " +
                        rs.getString("email") +
                        "</td>"
                );

                out.println("</tr>");
            }

            out.println("</table>");

            // =========================================
            // 🏠 BACK BUTTON
            // =========================================

            out.println(
                    "<a href='adminDashboard.jsp'>" +
                    "🏠 Back to Admin Dashboard" +
                    "</a>"
            );

            out.println("</div>");

            out.println("</body>");

            out.println("</html>");

            // =========================================
            // 🔒 CLOSE DATABASE RESOURCES
            // =========================================

            rs.close();

            ps.close();

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            out.println(
                    "<h2>❌ Error loading students</h2>");

            out.println(
                    "<p>" +
                    e.getMessage() +
                    "</p>");
        }
    }
}