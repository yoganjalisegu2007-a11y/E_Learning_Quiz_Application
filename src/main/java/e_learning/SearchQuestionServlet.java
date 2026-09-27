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

@WebServlet("/SearchQuestionServlet")
public class SearchQuestionServlet extends HttpServlet {

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

        // =========================================
        // GET SEARCH KEYWORD
        // =========================================

        String keyword =
                request.getParameter("keyword");

        if (keyword == null ||
            keyword.trim().isEmpty()) {

            response.sendRedirect("studentSearch.jsp");
            return;
        }

        keyword = keyword.trim();

        // =========================================
        // GET QUESTIONS FROM DATABASE
        // =========================================

        String sql =
                "SELECT id, question " +
                "FROM questions";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            // First count the questions
            int count = 0;

            while (rs.next()) {
                count++;
            }

            // Move ResultSet back to beginning
            rs.close();

            ps.close();

            /*
             * Get the questions again.
             */
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            /*
             * QuestionSearch expects:
             *
             * String[][]
             *
             * Column 0 = Question ID
             * Column 1 = Question text
             */

            String[][] questions =
                    new String[count][2];

            int i = 0;

            while (rs.next()) {

                questions[i][0] =
                        rs.getString("id");

                questions[i][1] =
                        rs.getString("question");

                i++;
            }

            rs.close();
            ps.close();
            con.close();

            // =========================================
            // LINEAR SEARCH
            // =========================================

            int position =
                    QuestionSearch.linearSearch(
                            questions,
                            keyword);

            String result;

            if (position != -1) {

                result =
                        "Question found at position "
                        + (position + 1)
                        + ": "
                        + questions[position][1];

            } else {

                result =
                        "No question found for the keyword: "
                        + keyword;
            }

            // =========================================
            // SEND RESULT TO JSP
            // =========================================

            request.setAttribute(
                    "result",
                    result);

            request.getRequestDispatcher(
                    "studentSearch.jsp")
                   .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error searching questions</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}