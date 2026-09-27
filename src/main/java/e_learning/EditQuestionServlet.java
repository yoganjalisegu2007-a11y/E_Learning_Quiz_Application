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

@WebServlet("/EditQuestionServlet")
public class EditQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================================
    // ✏️ LOAD QUESTION FOR EDITING
    // =========================================

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK ADMIN LOGIN

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 🆔 GET QUESTION ID

        String idText =
                request.getParameter("id");

        if (idText == null ||
            idText.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        int questionId;

        try {

            questionId =
                    Integer.parseInt(idText);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        // 🔎 GET QUESTION DETAILS

        String sql =
                "SELECT * " +
                "FROM questions " +
                "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, questionId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                // 🆔 QUESTION ID

                request.setAttribute(
                        "questionId",
                        rs.getInt("id"));

                // 🆔 QUIZ ID

                request.setAttribute(
                        "quizId",
                        rs.getInt("quiz_id"));

                // 📚 SUBJECT ID

                request.setAttribute(
                        "subjectId",
                        rs.getInt("subject_id"));

                // ❓ QUESTION

                request.setAttribute(
                        "question",
                        rs.getString("question"));

                // 🅰️ OPTION A

                request.setAttribute(
                        "optionA",
                        rs.getString("option_a"));

                // 🅱️ OPTION B

                request.setAttribute(
                        "optionB",
                        rs.getString("option_b"));

                // ©️ OPTION C

                request.setAttribute(
                        "optionC",
                        rs.getString("option_c"));

                // 🅳 OPTION D

                request.setAttribute(
                        "optionD",
                        rs.getString("option_d"));

                // ✅ CORRECT ANSWER

                request.setAttribute(
                        "correctAnswer",
                        rs.getString("correct_answer"));

                // 🎯 DIFFICULTY

                request.setAttribute(
                        "difficulty",
                        rs.getString("difficulty"));

                rs.close();
                ps.close();
                con.close();

                // ✏️ OPEN EDIT PAGE

                request.getRequestDispatcher(
                        "editQuestion.jsp")
                       .forward(
                        request,
                        response);

            } else {

                rs.close();
                ps.close();
                con.close();

                response.sendRedirect(
                        "ManageQuizzesServlet");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error Loading Question</h2>");

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>");
        }
    }


    // =========================================
    // 💾 UPDATE QUESTION
    // =========================================

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK ADMIN LOGIN

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 🆔 GET QUESTION ID

        String questionIdText =
                request.getParameter(
                        "questionId");

        // 🆔 GET QUIZ ID

        String quizIdText =
                request.getParameter(
                        "quizId");

        if (questionIdText == null ||
            quizIdText == null ||
            questionIdText.trim().isEmpty() ||
            quizIdText.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        int questionId;
        int quizId;

        try {

            questionId =
                    Integer.parseInt(
                            questionIdText);

            quizId =
                    Integer.parseInt(
                            quizIdText);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        // 📚 GET SUBJECT ID

        String subjectIdText =
                request.getParameter(
                        "subjectId");

        if (subjectIdText == null ||
            subjectIdText.trim().isEmpty()) {

            response.sendRedirect(
                    "manageQuestions.jsp?quizId=" +
                    quizId);

            return;
        }

        int subjectId;

        try {

            subjectId =
                    Integer.parseInt(
                            subjectIdText);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "manageQuestions.jsp?quizId=" +
                    quizId);

            return;
        }

        // ❓ GET QUESTION

        String question =
                request.getParameter(
                        "question");

        // 🅰️ GET OPTION A

        String optionA =
                request.getParameter(
                        "optionA");

        // 🅱️ GET OPTION B

        String optionB =
                request.getParameter(
                        "optionB");

        // ©️ GET OPTION C

        String optionC =
                request.getParameter(
                        "optionC");

        // 🅳 GET OPTION D

        String optionD =
                request.getParameter(
                        "optionD");

        // ✅ GET CORRECT ANSWER

        String correctAnswer =
                request.getParameter(
                        "correctAnswer");

        // 🎯 GET DIFFICULTY

        String difficulty =
                request.getParameter(
                        "difficulty");

        // =========================================
        // 💾 UPDATE DATABASE
        // =========================================

        String sql =
                "UPDATE questions SET " +
                "quiz_id = ?, " +
                "subject_id = ?, " +
                "question = ?, " +
                "option_a = ?, " +
                "option_b = ?, " +
                "option_c = ?, " +
                "option_d = ?, " +
                "correct_answer = ?, " +
                "difficulty = ? " +
                "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            // 🆔 QUIZ ID

            ps.setInt(1, quizId);

            // 📚 SUBJECT ID

            ps.setInt(2, subjectId);

            // ❓ QUESTION

            ps.setString(3, question);

            // 🅰️ OPTION A

            ps.setString(4, optionA);

            // 🅱️ OPTION B

            ps.setString(5, optionB);

            // ©️ OPTION C

            ps.setString(6, optionC);

            // 🅳 OPTION D

            ps.setString(7, optionD);

            // ✅ CORRECT ANSWER

            ps.setString(8, correctAnswer);

            // 🎯 DIFFICULTY

            ps.setString(9, difficulty);

            // 🆔 QUESTION ID

            ps.setInt(10, questionId);

            ps.executeUpdate();

            ps.close();
            con.close();

            // ↩️ RETURN TO THE SAME QUIZ

            response.sendRedirect(
                    "manageQuestions.jsp?quizId=" +
                    quizId);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error Updating Question</h2>");

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>");
        }
    }
}