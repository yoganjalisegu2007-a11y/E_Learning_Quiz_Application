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

@WebServlet("/AddSubjectServlet")
public class AddSubjectServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =========================================
        // CHECK ADMIN LOGIN
        // =========================================

        HttpSession session =
                request.getSession();

        if (session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // =========================================
        // GET SUBJECT NAME
        // =========================================

        String subjectName =
                request.getParameter("subjectName");

        // =========================================
        // INSERT SUBJECT
        // =========================================

        String sql =
                "INSERT INTO subjects " +
                "(subject_name) VALUES (?)";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    subjectName);

            int result =
                    ps.executeUpdate();

            ps.close();
            con.close();

            // =========================================
            // CHECK RESULT
            // =========================================

            if (result > 0) {

                response.sendRedirect(
                        "manageSubjects.jsp");

            } else {

                response.getWriter().println(
                        "<h2>Subject could not be added</h2>"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error adding subject</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}