package e_learning;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =========================================
        // 🔐 CHECK STUDENT LOGIN
        // =========================================

        HttpSession session =
                request.getSession();

        if (session.getAttribute("studentId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // =========================================
        // 🆔 GET QUIZ ID
        // =========================================

        String quizIdText =
                request.getParameter("quizId");

        if (quizIdText == null ||
            quizIdText.trim().isEmpty()) {

            response.sendRedirect(
                    "studentDashboard.jsp");

            return;
        }

        int quizId;

        try {

            quizId =
                    Integer.parseInt(quizIdText);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "studentDashboard.jsp");

            return;
        }

        // =========================================
        // 📚 QUIZ DETAILS
        // =========================================

        String quizName = "";
        String subjectName = "";
        int timeLimit = 0;

        Timestamp startTime = null;
        Timestamp endTime = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            // =========================================
            // 🔎 GET QUIZ DETAILS
            // =========================================

            String quizSql =
                    "SELECT q.quiz_name, " +
                    "q.time_limit, " +
                    "q.start_time, " +
                    "q.end_time, " +
                    "s.subject_name " +
                    "FROM quizzes q " +
                    "JOIN subjects s " +
                    "ON q.subject_id = s.id " +
                    "WHERE q.id = ?";

            PreparedStatement quizPs =
                    con.prepareStatement(quizSql);

            quizPs.setInt(
                    1,
                    quizId);

            ResultSet quizRs =
                    quizPs.executeQuery();

            if (!quizRs.next()) {

                quizRs.close();
                quizPs.close();
                con.close();

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>❌ Quiz Not Found</h2>"
                );

                response.getWriter().println(
                        "<p>The selected quiz does not exist.</p>"
                );

                response.getWriter().println(
                        "<a href='studentDashboard.jsp'>" +
                        "🔙 Back to Dashboard" +
                        "</a>"
                );

                return;
            }

            quizName =
                    quizRs.getString("quiz_name");

            subjectName =
                    quizRs.getString("subject_name");

            timeLimit =
                    quizRs.getInt("time_limit");

            startTime =
                    quizRs.getTimestamp("start_time");

            endTime =
                    quizRs.getTimestamp("end_time");

            quizRs.close();
            quizPs.close();

            // =========================================
            // ⏰ CHECK CURRENT TIME
            // =========================================

            Timestamp currentTime =
                    new Timestamp(
                            System.currentTimeMillis());

            // =========================================
            // 🟡 QUIZ NOT STARTED YET
            // =========================================

            if (currentTime.before(startTime)) {

                con.close();

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>🟡 Quiz Not Started</h2>"
                );

                response.getWriter().println(
                        "<p>📅 This quiz will open at:</p>"
                );

                response.getWriter().println(
                        "<h3>" +
                        startTime +
                        "</h3>"
                );

                response.getWriter().println(
                        "<br>"
                );

                response.getWriter().println(
                        "<a href='studentDashboard.jsp'>" +
                        "🔙 Back to Dashboard" +
                        "</a>"
                );

                return;
            }

            // =========================================
            // 🔴 QUIZ ALREADY CLOSED
            // =========================================

            if (!currentTime.before(endTime)) {

                con.close();

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>🔴 Quiz Closed</h2>"
                );

                response.getWriter().println(
                        "<p>⏰ The deadline for this quiz has passed.</p>"
                );

                response.getWriter().println(
                        "<p>🔒 You can no longer start this quiz.</p>"
                );

                response.getWriter().println(
                        "<br>"
                );

                response.getWriter().println(
                        "<a href='studentDashboard.jsp'>" +
                        "🔙 Back to Dashboard" +
                        "</a>"
                );

                return;
            }

            // =========================================
            // 📝 CREATE QUESTION LIST
            // =========================================

            ArrayList<String[]> questions =
                    new ArrayList<String[]>();

            // =========================================
            // 🧠 CREATE QUESTION QUEUE
            // =========================================

            QuestionQueue questionQueue =
                    new QuestionQueue();

            // =========================================
            // 🔎 GET QUESTIONS FOR THIS QUIZ ONLY
            // =========================================

            String questionSql =
                    "SELECT id, question, " +
                    "option_a, option_b, " +
                    "option_c, option_d, " +
                    "difficulty " +
                    "FROM questions " +
                    "WHERE quiz_id = ? " +
                    "ORDER BY id";

            PreparedStatement questionPs =
                    con.prepareStatement(
                            questionSql);

            questionPs.setInt(
                    1,
                    quizId);

            ResultSet rs =
                    questionPs.executeQuery();

            while (rs.next()) {

                /*
                 * Array positions:
                 *
                 * 0 = Question ID
                 * 1 = Question
                 * 2 = Option A
                 * 3 = Option B
                 * 4 = Option C
                 * 5 = Option D
                 * 6 = Difficulty
                 */

                String[] question =
                        new String[7];

                question[0] =
                        rs.getString("id");

                question[1] =
                        rs.getString("question");

                question[2] =
                        rs.getString("option_a");

                question[3] =
                        rs.getString("option_b");

                question[4] =
                        rs.getString("option_c");

                question[5] =
                        rs.getString("option_d");

                question[6] =
                        rs.getString("difficulty");

                // ➕ ADD QUESTION TO QUEUE
                questionQueue.addQuestion(
                        question);
            }

            // =========================================
            // 📤 REMOVE QUESTIONS FROM QUEUE
            // =========================================

            while (!questionQueue.isEmpty()) {

                String[] question =
                        questionQueue.getQuestion();

                questions.add(question);
            }

            rs.close();
            questionPs.close();
            con.close();

            // =========================================
            // ❌ NO QUESTIONS
            // =========================================

            if (questions.isEmpty()) {

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>❌ No Questions Available</h2>"
                );

                response.getWriter().println(
                        "<p>📝 No questions have been added " +
                        "to this quiz yet.</p>"
                );

                response.getWriter().println(
                        "<br>"
                );

                response.getWriter().println(
                        "<a href='studentDashboard.jsp'>" +
                        "🔙 Back to Dashboard" +
                        "</a>"
                );

                return;
            }

            // =========================================
            // 📤 SEND DATA TO QUIZ.JSP
            // =========================================

            request.setAttribute(
                    "questions",
                    questions);

            request.setAttribute(
                    "quizId",
                    quizId);

            request.setAttribute(
                    "quizName",
                    quizName);

            request.setAttribute(
                    "subjectName",
                    subjectName);

            request.setAttribute(
                    "timeLimit",
                    timeLimit);

            request.setAttribute(
                    "startTime",
                    startTime);

            request.setAttribute(
                    "endTime",
                    endTime);

            // =========================================
            // 🚀 OPEN QUIZ PAGE
            // =========================================

            request.getRequestDispatcher(
                    "quiz.jsp")
                   .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error Loading Quiz</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}