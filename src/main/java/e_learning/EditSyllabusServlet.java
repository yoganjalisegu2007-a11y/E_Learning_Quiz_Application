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

@WebServlet("/EditSyllabusServlet")
public class EditSyllabusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================
    // LOAD SYLLABUS FOR EDITING
    // =========================
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String idText = request.getParameter("id");

        // Check syllabus ID
        if (idText == null ||
            idText.trim().isEmpty()) {

            response.sendRedirect("manageSyllabus.jsp");
            return;
        }

        int id = Integer.parseInt(idText);

        String sql =
                "SELECT id, subject_id, title, content " +
                "FROM syllabus " +
                "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                // Send data to editSyllabus.jsp
                request.setAttribute(
                        "syllabusId",
                        rs.getInt("id"));

                request.setAttribute(
                        "subjectId",
                        rs.getInt("subject_id"));

                request.setAttribute(
                        "title",
                        rs.getString("title"));

                request.setAttribute(
                        "content",
                        rs.getString("content"));

                rs.close();
                ps.close();
                con.close();

                request.getRequestDispatcher(
                        "editSyllabus.jsp")
                        .forward(request, response);

            } else {

                rs.close();
                ps.close();
                con.close();

                response.sendRedirect(
                        "manageSyllabus.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error loading syllabus</h2>");

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>");
        }
    }


    // =========================
    // UPDATE SYLLABUS
    // =========================
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String idText =
                request.getParameter("id");

        String subjectIdText =
                request.getParameter("subjectId");

        String title =
                request.getParameter("title");

        String content =
                request.getParameter("content");

        // Check required values
        if (idText == null ||
            subjectIdText == null ||
            title == null ||
            content == null) {

            response.sendRedirect(
                    "manageSyllabus.jsp");

            return;
        }

        int id =
                Integer.parseInt(idText);

        int subjectId =
                Integer.parseInt(subjectIdText);

        String sql =
                "UPDATE syllabus " +
                "SET subject_id = ?, " +
                "title = ?, " +
                "content = ? " +
                "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, subjectId);
            ps.setString(2, title);
            ps.setString(3, content);
            ps.setInt(4, id);

            int result =
                    ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {

                response.sendRedirect(
                        "manageSyllabus.jsp");

            } else {

                response.setContentType(
                        "text/html;charset=UTF-8");

                response.getWriter().println(
                        "<h2>Syllabus could not be updated</h2>");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Error updating syllabus</h2>");

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>");
        }
    }
}