package e_learning;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PerformanceServlet")
public class PerformanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =========================================
        // CHECK STUDENT LOGIN
        // =========================================

        HttpSession session =
                request.getSession();

        if (session.getAttribute("studentId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in student ID
        int studentId =
                (Integer) session.getAttribute("studentId");

        // =========================================
        // VARIABLES
        // =========================================

        int totalQuizzes = 0;
        int totalQuestions = 0;

        double averageScore = 0;
        double averagePercentage = 0;

        int highestScore = 0;

        double latestPercentage = 0;

        // =========================================
        // DATABASE QUERY
        // =========================================

        String sql =
                "SELECT " +
                "COUNT(*) AS total_quizzes, " +
                "SUM(total) AS total_questions, " +
                "AVG(score) AS average_score, " +
                "AVG(percentage) AS average_percentage, " +
                "MAX(score) AS highest_score " +
                "FROM quiz_results " +
                "WHERE student_id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, studentId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                totalQuizzes =
                        rs.getInt("total_quizzes");

                totalQuestions =
                        rs.getInt("total_questions");

                averageScore =
                        rs.getDouble("average_score");

                averagePercentage =
                        rs.getDouble("average_percentage");

                highestScore =
                        rs.getInt("highest_score");
            }

            rs.close();
            ps.close();
            con.close();

            // =========================================
            // GET LATEST QUIZ PERCENTAGE
            // =========================================

            String latestSQL =
                    "SELECT percentage " +
                    "FROM quiz_results " +
                    "WHERE student_id = ? " +
                    "ORDER BY id DESC " +
                    "LIMIT 1";

            Connection con2 =
                    DBConnection.getConnection();

            PreparedStatement ps2 =
                    con2.prepareStatement(latestSQL);

            ps2.setInt(1, studentId);

            ResultSet rs2 =
                    ps2.executeQuery();

            if (rs2.next()) {

                latestPercentage =
                        rs2.getDouble("percentage");
            }

            rs2.close();
            ps2.close();
            con2.close();

            // =========================================
            // SEND DATA TO JSP
            // =========================================

            request.setAttribute(
                    "totalQuizzes",
                    totalQuizzes);

            request.setAttribute(
                    "totalQuestions",
                    totalQuestions);

            request.setAttribute(
                    "averageScore",
                    averageScore);

            request.setAttribute(
                    "averagePercentage",
                    averagePercentage);

            request.setAttribute(
                    "highestScore",
                    highestScore);

            request.setAttribute(
                    "latestPercentage",
                    latestPercentage);

            request.getRequestDispatcher(
                    "performance.jsp")
                   .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error loading performance</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}