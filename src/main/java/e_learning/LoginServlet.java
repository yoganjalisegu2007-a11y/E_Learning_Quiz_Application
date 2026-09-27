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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get login details
        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        // Check empty fields
        if (email == null ||
            password == null ||
            email.trim().isEmpty() ||
            password.trim().isEmpty()) {

            response.sendRedirect("login.jsp");
            return;
        }

        String sql =
                "SELECT id, name, email " +
                "FROM students " +
                "WHERE email = ? AND password = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                // Create/get session
                HttpSession session =
                        request.getSession();

                // Store student information
                session.setAttribute(
                        "studentId",
                        rs.getInt("id"));

                session.setAttribute(
                        "studentName",
                        rs.getString("name"));

                session.setAttribute(
                        "studentEmail",
                        rs.getString("email"));

                rs.close();
                ps.close();
                con.close();

                // IMPORTANT:
                // After student login, open dashboard
                response.sendRedirect(
                        "dashboard.jsp");

                return;

            } else {

                rs.close();
                ps.close();
                con.close();

                // Login failed
                response.sendRedirect(
                        "login.jsp?error=invalid");

                return;
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8");

            response.getWriter().println(
                    "<h2>Login Error</h2>");

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>");
        }
    }
}