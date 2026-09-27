package e_learning;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/AdminSearchQuestionServlet")
public class AdminSearchQuestionServlet extends HttpServlet {

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
        // 🆔 GET QUIZ ID
        // =========================================

        String quizIdText =
                request.getParameter("quizId");

        if (quizIdText == null ||
            quizIdText.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        int quizId;

        try {

            quizId =
                    Integer.parseInt(quizIdText);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "ManageQuizzesServlet");

            return;
        }

        // =========================================
        // 🔎 GET SEARCH TEXT
        // =========================================

        String searchText =
                request.getParameter("search");

        if (searchText == null) {
            searchText = "";
        }

        searchText =
                searchText.trim();

        // =========================================
        // 📋 CREATE QUESTION LIST
        // =========================================

        ArrayList<String[]> questions =
                new ArrayList<String[]>();

        String sql =
                "SELECT id, question " +
                "FROM questions " +
                "WHERE quiz_id = ? " +
                "ORDER BY id";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            // 🆔 ONLY QUESTIONS FROM THIS QUIZ

            ps.setInt(1, quizId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                String[] question =
                        new String[2];

                question[0] =
                        rs.getString("id");

                question[1] =
                        rs.getString("question");

                questions.add(question);
            }

            rs.close();
            ps.close();
            con.close();

            // =========================================
            // 🔄 CONVERT ARRAYLIST TO 2D ARRAY
            // =========================================

            String[][] questionArray =
                    new String[questions.size()][2];

            for (int i = 0;
                 i < questions.size();
                 i++) {

                questionArray[i][0] =
                        questions.get(i)[0];

                questionArray[i][1] =
                        questions.get(i)[1];
            }

            // =========================================
            // 🔍 ADSA LINEAR SEARCH
            // =========================================

            int result = -1;

            if (!searchText.isEmpty()) {

                result =
                        QuestionSearch.linearSearch(
                                questionArray,
                                searchText);
            }

            // =========================================
            // 🌐 SEARCH RESULT PAGE
            // =========================================

            out.println("<!DOCTYPE html>");

            out.println("<html>");

            out.println("<head>");

            out.println(
                    "<meta charset='UTF-8'>");

            out.println(
                    "<title>🔎 Search Question</title>");

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
                    "max-width:800px;" +
                    "margin:auto;" +
                    "border-radius:15px;" +
                    "box-shadow:0 5px 18px " +
                    "rgba(0,0,0,0.08);" +
                    "}"
            );

            out.println(
                    "h1 {" +
                    "color:#0B2D5C;" +
                    "}"
            );

            out.println(
                    ".quiz-info {" +
                    "background:#eef4ff;" +
                    "padding:15px;" +
                    "border-radius:8px;" +
                    "margin:20px 0;" +
                    "}"
            );

            out.println(
                    "input {" +
                    "width:70%;" +
                    "padding:12px;" +
                    "border:2px solid #eeeeee;" +
                    "border-radius:8px;" +
                    "}"
            );

            out.println(
                    "button {" +
                    "padding:12px 20px;" +
                    "background:#0B2D5C;" +
                    "color:white;" +
                    "border:none;" +
                    "border-radius:8px;" +
                    "font-weight:bold;" +
                    "cursor:pointer;" +
                    "}"
            );

            out.println(
                    ".result {" +
                    "margin-top:25px;" +
                    "padding:20px;" +
                    "background:#f7f9fc;" +
                    "border-radius:10px;" +
                    "}"
            );

            out.println(
                    ".back {" +
                    "display:inline-block;" +
                    "margin-top:20px;" +
                    "padding:10px 18px;" +
                    "background:#0B2D5C;" +
                    "color:white;" +
                    "text-decoration:none;" +
                    "border-radius:8px;" +
                    "}"
            );

            out.println("</style>");

            out.println("</head>");

            out.println("<body>");

            out.println(
                    "<div class='box'>");

            out.println(
                    "<h1>🔎 Search Question</h1>");

            out.println(
                    "<div class='quiz-info'>" +
                    "🆔 Quiz ID: <strong>" +
                    quizId +
                    "</strong>" +
                    "</div>"
            );

            // =========================================
            // 🔎 SEARCH FORM
            // =========================================

            out.println(
                    "<form " +
                    "action='AdminSearchQuestionServlet' " +
                    "method='get'>"
            );

            // 🆔 KEEP QUIZ ID

            out.println(
                    "<input type='hidden' " +
                    "name='quizId' " +
                    "value='" +
                    quizId +
                    "'>"
            );

            out.println(
                    "<input type='text' " +
                    "name='search' " +
                    "placeholder='🔎 Enter question keyword' " +
                    "value='" +
                    searchText +
                    "' " +
                    "required>"
            );

            out.println(
                    "<button type='submit'>" +
                    "🔎 Search" +
                    "</button>"
            );

            out.println("</form>");

            // =========================================
            // 📋 DISPLAY SEARCH RESULT
            // =========================================

            if (!searchText.isEmpty()) {

                out.println(
                        "<div class='result'>");

                if (result != -1) {

                    out.println(
                            "<h3>✅ Question Found</h3>");

                    out.println(
                            "<p><strong>" +
                            "🆔 Question ID: " +
                            questionArray[result][0] +
                            "</strong></p>"
                    );

                    out.println(
                            "<p>❓ " +
                            questionArray[result][1] +
                            "</p>"
                    );

                } else {

                    out.println(
                            "<h3>❌ Question Not Found</h3>");

                    out.println(
                            "<p>" +
                            "No matching question was found " +
                            "inside this quiz." +
                            "</p>"
                    );
                }

                out.println("</div>");
            }

            // =========================================
            // ↩️ BACK TO MANAGE QUESTIONS
            // =========================================

            out.println(
                    "<a " +
                    "href='manageQuestions.jsp?quizId=" +
                    quizId +
                    "' " +
                    "class='back'>" +
                    "↩️ Back to Manage Questions" +
                    "</a>"
            );

            out.println("</div>");

            out.println("</body>");

            out.println("</html>");

        } catch (Exception e) {

            e.printStackTrace();

            out.println(
                    "<h2>❌ Search Error</h2>"
            );

            out.println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}