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

@WebServlet("/DeleteSyllabusServlet")
public class DeleteSyllabusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // CHECK ADMIN LOGIN
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String idText =
                request.getParameter("id");

        if (idText == null ||
            idText.trim().isEmpty()) {

            response.sendRedirect(
                    "manageSyllabus.jsp");

            return;
        }

        int id =
                Integer.parseInt(idText);

        String sql =
                "DELETE FROM syllabus " +
                "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

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
                    "<h2>Error deleting syllabus</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}