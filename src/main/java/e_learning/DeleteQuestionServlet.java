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

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 CHECK ADMIN LOGIN

        HttpSession session =
                request.getSession();

        if (session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                    "adminLogin.jsp");

            return;
        }


        // 🆔 GET QUESTION ID

        String questionIdText =
                request.getParameter("id");

        if (questionIdText == null ||
            questionIdText.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }


        int questionId =
                Integer.parseInt(questionIdText);


        // 🆔 GET QUIZ ID

        String quizIdText =
                request.getParameter("quizId");

        int quizId = 0;


        try {

            Connection con =
                    DBConnection.getConnection();


            /*
             * 🔎 If quizId was not sent,
             * find it using the question ID.
             */

            if (quizIdText == null ||
                quizIdText.trim().isEmpty()) {

                String findSql =
                        "SELECT quiz_id " +
                        "FROM questions " +
                        "WHERE id = ?";

                PreparedStatement findPs =
                        con.prepareStatement(findSql);

                findPs.setInt(
                        1,
                        questionId);

                ResultSet rs =
                        findPs.executeQuery();

                if (rs.next()) {

                    quizId =
                            rs.getInt("quiz_id");

                }

                rs.close();
                findPs.close();

            } else {

                quizId =
                        Integer.parseInt(quizIdText);
            }


            // 🗑️ DELETE QUESTION

            String deleteSql =
                    "DELETE FROM questions " +
                    "WHERE id = ? AND quiz_id = ?";


            PreparedStatement deletePs =
                    con.prepareStatement(
                            deleteSql);


            deletePs.setInt(
                    1,
                    questionId);

            deletePs.setInt(
                    2,
                    quizId);


            int result =
                    deletePs.executeUpdate();


            deletePs.close();
            con.close();


            // 🔄 GO BACK TO QUESTIONS

            if (result > 0) {

                response.sendRedirect(
                        "manageQuestions.jsp?quizId="
                        + quizId);

            } else {

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>❌ Question could not be deleted</h2>"
                );

                response.getWriter().println(
                        "<p>Question ID: "
                        + questionId
                        + "</p>"
                );

                response.getWriter().println(
                        "<br>"
                );

                response.getWriter().println(
                        "<a href='manageQuestions.jsp?quizId="
                        + quizId
                        + "'>🔙 Back to Questions</a>"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>❌ Delete Question Error</h2>"
            );

            response.getWriter().println(
                    "<p>"
                    + e.getMessage()
                    + "</p>"
            );
        }
    }
}