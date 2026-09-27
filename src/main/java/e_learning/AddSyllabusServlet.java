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

@WebServlet("/AddSyllabusServlet")
public class AddSyllabusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String subjectIdText =
                request.getParameter("subjectId");

        String title =
                request.getParameter("title");

        String content =
                request.getParameter("content");

        if (subjectIdText == null ||
            title == null ||
            content == null) {

            response.sendRedirect("manageSyllabus.jsp");
            return;
        }

        int subjectId =
                Integer.parseInt(subjectIdText);

        String sql =
                "INSERT INTO syllabus " +
                "(subject_id, title, content) " +
                "VALUES (?, ?, ?)";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, subjectId);
            ps.setString(2, title);
            ps.setString(3, content);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect(
                    "manageSyllabus.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error adding syllabus</h2>");

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>");
        }
    }
}