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

@WebServlet("/LeaderboardServlet")
public class LeaderboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> leaderboard =
                new ArrayList<String[]>();

        /*
         * Get student name and quiz result
         * from the database.
         */
        String sql =
                "SELECT s.name, " +
                "r.score, " +
                "r.total, " +
                "r.percentage " +
                "FROM quiz_results r " +
                "JOIN students s " +
                "ON r.student_id = s.id";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            /*
             * Read every quiz result.
             */
            while (rs.next()) {

                /*
                 * Array positions:
                 *
                 * 0 = Student name
                 * 1 = Score
                 * 2 = Total questions
                 * 3 = Percentage
                 */

                String[] row =
                        new String[4];

                row[0] =
                        rs.getString("name");

                row[1] =
                        rs.getString("score");

                row[2] =
                        rs.getString("total");

                row[3] =
                        rs.getString("percentage");

                leaderboard.add(row);
            }

            rs.close();
            ps.close();
            con.close();

            /*
             * Use our own ADSA Bubble Sort
             * instead of Collections.sort().
             */
            ScoreSorter.bubbleSort(
                    leaderboard);

            /*
             * Send sorted leaderboard
             * to leaderboard.jsp.
             */
            request.setAttribute(
                    "leaderboard",
                    leaderboard);

            request.getRequestDispatcher(
                    "leaderboard.jsp")
                   .forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error loading leaderboard</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}