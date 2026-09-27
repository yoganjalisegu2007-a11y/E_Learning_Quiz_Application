package e_learning;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK ADMIN LOGIN

        HttpSession session = request.getSession();

        if (session.getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 📝 GET QUESTION DETAILS

        int quizId = Integer.parseInt(
                request.getParameter("quizId"));

        int subjectId = Integer.parseInt(
                request.getParameter("subjectId"));

        String question =
                request.getParameter("question");

        String optionA =
                request.getParameter("optionA");

        String optionB =
                request.getParameter("optionB");

        String optionC =
                request.getParameter("optionC");

        String optionD =
                request.getParameter("optionD");

        String correctAnswer =
                request.getParameter("correctAnswer");

        String difficulty =
                request.getParameter("difficulty");

        // 💾 INSERT QUESTION INTO DATABASE

        String sql =
                "INSERT INTO questions " +
                "(quiz_id, subject_id, question, option_a, " +
                "option_b, option_c, option_d, " +
                "correct_answer, difficulty) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, quizId);
            ps.setInt(2, subjectId);
            ps.setString(3, question);
            ps.setString(4, optionA);
            ps.setString(5, optionB);
            ps.setString(6, optionC);
            ps.setString(7, optionD);
            ps.setString(8, correctAnswer);
            ps.setString(9, difficulty);

            int result =
                    ps.executeUpdate();

            ps.close();
            con.close();

            // ✅ CHECK RESULT

            if (result > 0) {

                response.sendRedirect(
                        "ManageQuizzesServlet");

            } else {

                response.getWriter().println(
                        "<h2>❌ Question could not be added</h2>"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Error adding question</h2>"
            );

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}