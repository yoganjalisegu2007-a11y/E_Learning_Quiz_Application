package e_learning;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateQuizServlet")
public class CreateQuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 🔐 Check whether admin is logged in
        if (session.getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try {

            // 📚 Get subject ID
            String subjectIdText =
                    request.getParameter("subjectId");

            // 📝 Get quiz name
            String quizName =
                    request.getParameter("quizName");

            // ⏱️ Get time limit
            String timeLimitText =
                    request.getParameter("timeLimit");

            // 🟢 Get start time
            String startTimeText =
                    request.getParameter("startTime");

            // 🔴 Get end time
            String endTimeText =
                    request.getParameter("endTime");


            // ❌ Validate empty values
            if (subjectIdText == null ||
                quizName == null ||
                timeLimitText == null ||
                startTimeText == null ||
                endTimeText == null ||
                subjectIdText.trim().isEmpty() ||
                quizName.trim().isEmpty() ||
                timeLimitText.trim().isEmpty() ||
                startTimeText.trim().isEmpty() ||
                endTimeText.trim().isEmpty()) {

                response.sendRedirect(
                        "createQuiz.jsp?error=invalid");

                return;
            }


            int subjectId =
                    Integer.parseInt(subjectIdText);

            int timeLimit =
                    Integer.parseInt(timeLimitText);


            // ⏱️ Time limit must be greater than zero
            if (timeLimit <= 0) {

                response.sendRedirect(
                        "createQuiz.jsp?error=invalid");

                return;
            }


            /*
             * datetime-local gives:
             *
             * 2026-09-25T18:30
             *
             * MySQL DATETIME requires:
             *
             * 2026-09-25 18:30:00
             */

            String formattedStartTime =
                    startTimeText.replace("T", " ") + ":00";

            String formattedEndTime =
                    endTimeText.replace("T", " ") + ":00";


            Timestamp startTime =
                    Timestamp.valueOf(formattedStartTime);

            Timestamp endTime =
                    Timestamp.valueOf(formattedEndTime);


            // 🔴 End time must be after start time
            if (!endTime.after(startTime)) {

                response.sendRedirect(
                        "createQuiz.jsp?error=time");

                return;
            }


            String sql =
                    "INSERT INTO quizzes " +
                    "(subject_id, quiz_name, time_limit, " +
                    "start_time, end_time) " +
                    "VALUES (?, ?, ?, ?, ?)";


            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(1, subjectId);

            ps.setString(2, quizName);

            ps.setInt(3, timeLimit);

            ps.setTimestamp(4, startTime);

            ps.setTimestamp(5, endTime);


            int rows =
                    ps.executeUpdate();


            ps.close();
            con.close();


            if (rows > 0) {

                response.sendRedirect(
                        "createQuiz.jsp?success=created");

            } else {

                response.sendRedirect(
                        "createQuiz.jsp?error=invalid");
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Quiz Creation Error</h2>"
            );

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}