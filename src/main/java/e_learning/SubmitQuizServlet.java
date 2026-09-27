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

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK STUDENT LOGIN
        HttpSession session =
                request.getSession();

        if (session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 👨‍🎓 GET STUDENT ID
        int studentId =
                (Integer) session.getAttribute("studentId");

        // 🆔 GET QUIZ ID
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

        int score = 0;
        int total = 0;

        // 📚 ANSWER STACK - ADSA
        AnswerStack answerStack =
                new AnswerStack();

        String sql =
                "SELECT id, correct_answer " +
                "FROM questions " +
                "WHERE quiz_id = ? " +
                "ORDER BY id";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, quizId);

            ResultSet rs =
                    ps.executeQuery();

            // 📝 CHECK EACH QUESTION
            while (rs.next()) {

                int questionId =
                        rs.getInt("id");

                String correctAnswer =
                        rs.getString(
                                "correct_answer");

                total++;

                // 👤 GET STUDENT ANSWER
                String studentAnswer =
                        request.getParameter(
                                "answer_" + questionId);

                // 📚 STORE ANSWER IN STACK
                if (studentAnswer != null) {

                    answerStack.pushAnswer(
                            studentAnswer);

                } else {

                    answerStack.pushAnswer(
                            "Not Answered");
                }

                // ✅ CHECK ANSWER
                if (studentAnswer != null &&
                    studentAnswer.equalsIgnoreCase(
                            correctAnswer)) {

                    score++;
                }
            }

            rs.close();
            ps.close();
            con.close();

            // 📊 CALCULATE PERCENTAGE
            double percentage = 0;

            if (total > 0) {

                percentage =
                        ((double) score / total)
                        * 100;
            }

            // 💾 SAVE QUIZ RESULT
            String insertSQL =
                    "INSERT INTO quiz_results " +
                    "(student_id, quiz_id, score, " +
                    "total, percentage) " +
                    "VALUES (?, ?, ?, ?, ?)";

            Connection con2 =
                    DBConnection.getConnection();

            PreparedStatement ps2 =
                    con2.prepareStatement(
                            insertSQL);

            ps2.setInt(1, studentId);
            ps2.setInt(2, quizId);
            ps2.setInt(3, score);
            ps2.setInt(4, total);
            ps2.setDouble(5, percentage);

            ps2.executeUpdate();

            ps2.close();
            con2.close();

            // 📤 SEND RESULT TO RESULT PAGE
            request.setAttribute(
                    "score",
                    score);

            request.setAttribute(
                    "total",
                    total);

            request.setAttribute(
                    "percentage",
                    percentage);

            request.setAttribute(
                    "quizId",
                    quizId);

            request.setAttribute(
                    "answerStack",
                    answerStack);

            request.getRequestDispatcher(
                    "result.jsp")
                    .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error Submitting Quiz</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}