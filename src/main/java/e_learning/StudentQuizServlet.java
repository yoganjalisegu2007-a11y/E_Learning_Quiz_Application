package e_learning;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StudentQuizServlet")
public class StudentQuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK STUDENT LOGIN

        HttpSession session = request.getSession();

        if (session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 📝 STORE QUIZ DETAILS

        ArrayList<String[]> quizzes =
                new ArrayList<String[]>();

        String sql =
                "SELECT q.id, " +
                "q.quiz_name, " +
                "s.subject_name, " +
                "q.time_limit, " +
                "q.start_time, " +
                "q.end_time " +
                "FROM quizzes q " +
                "JOIN subjects s " +
                "ON q.subject_id = s.id " +
                "ORDER BY q.start_time ASC";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                /*
                 * Array positions:
                 *
                 * 0 = Quiz ID
                 * 1 = Quiz Name
                 * 2 = Subject Name
                 * 3 = Time Limit
                 * 4 = Start Time
                 * 5 = End Time
                 */

                String[] quiz =
                        new String[6];

                quiz[0] =
                        rs.getString("id");

                quiz[1] =
                        rs.getString("quiz_name");

                quiz[2] =
                        rs.getString("subject_name");

                quiz[3] =
                        rs.getString("time_limit");

                quiz[4] =
                        rs.getString("start_time");

                quiz[5] =
                        rs.getString("end_time");

                quizzes.add(quiz);
            }

            rs.close();
            ps.close();
            con.close();

            // 📦 SEND QUIZZES TO JSP

            request.setAttribute(
                    "quizzes",
                    quizzes);

            request.getRequestDispatcher(
                    "studentQuizzes.jsp")
                    .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error Loading Quizzes</h2>"
            );

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}