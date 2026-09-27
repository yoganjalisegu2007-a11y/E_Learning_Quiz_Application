package e_learning;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "INSERT INTO students (name, email, password) VALUES (?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {

                out.println("<h2>Database Connection Failed</h2>");
                out.println("<p>Please check your MySQL password and database.</p>");
                return;
            }

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int result = ps.executeUpdate();

            if (result > 0) {

                response.sendRedirect("login.jsp");

            } else {

                out.println("<h2>Registration Failed</h2>");
                out.println("<p>Student could not be registered.</p>");
            }

            ps.close();
            con.close();

        } catch (SQLIntegrityConstraintViolationException e) {

            out.println("<h2>Email Already Registered</h2>");
            out.println("<p>This email is already present in the database.</p>");
            out.println("<a href='register.jsp'>Try Again</a>");

        } catch (Exception e) {

            e.printStackTrace();

            out.println("<h2>Registration Error</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='register.jsp'>Go Back</a>");
        }
    }
}