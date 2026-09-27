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

@WebServlet("/AdminResultsServlet")
public class AdminResultsServlet extends HttpServlet {

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
        // 📊 SQL QUERY
        // =========================================

        String sql =
                "SELECT students.name, students.email, " +
                "quiz_results.score, quiz_results.total, " +
                "quiz_results.percentage " +
                "FROM quiz_results " +
                "JOIN students " +
                "ON quiz_results.student_id = students.id " +
                "ORDER BY quiz_results.percentage DESC";

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
                    "<title>📊 Quiz Results</title>");

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
                    "max-width:1100px;" +
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
                    "margin-top:25px;" +
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
                    ".empty {" +
                    "color:#777;" +
                    "text-align:center;" +
                    "padding:20px;" +
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
                    "transform:translateY(-2px);" +
                    "}"
            );

            out.println("</style>");

            out.println("</head>");

            out.println("<body>");

            out.println(
                    "<div class='box'>");

            out.println(
                    "<h1>📊 Student Quiz Results</h1>");

            out.println(
                    "<div class='subtitle'>" +
                    "📝 View quiz scores and performance of all students" +
                    "</div>");

            out.println("<table>");

            out.println("<tr>");

            out.println(
                    "<th>👤 Student Name</th>");

            out.println(
                    "<th>📧 Email</th>");

            out.println(
                    "<th>🎯 Score</th>");

            out.println(
                    "<th>❓ Total</th>");

            out.println(
                    "<th>📈 Percentage</th>");

            out.println("</tr>");

            boolean hasResults = false;

            // =========================================
            // 📋 DISPLAY RESULTS
            // =========================================

            while (rs.next()) {

                hasResults = true;

                out.println("<tr>");

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

                out.println(
                        "<td>🎯 " +
                        rs.getInt("score") +
                        "</td>"
                );

                out.println(
                        "<td>❓ " +
                        rs.getInt("total") +
                        "</td>"
                );

                out.println(
                        "<td>📈 " +
                        String.format(
                                "%.2f",
                                rs.getDouble(
                                        "percentage"))
                        + "%" +
                        "</td>"
                );

                out.println("</tr>");
            }

            // =========================================
            // 📭 NO RESULTS
            // =========================================

            if (!hasResults) {

                out.println("<tr>");

                out.println(
                        "<td colspan='5' class='empty'>");

                out.println(
                        "📭 No quiz results available.");

                out.println("</td>");

                out.println("</tr>");
            }

            out.println("</table>");

            // =========================================
            // 🏠 BACK BUTTON
            // =========================================

            out.println(
                    "<a href='adminDashboard.jsp'>");

            out.println(
                    "🏠 Back to Admin Dashboard");

            out.println("</a>");

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
                    "<h2>❌ Error loading quiz results</h2>");

            out.println(
                    "<p>" +
                    e.getMessage() +
                    "</p>");
        }
    }
}