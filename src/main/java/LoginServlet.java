import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse res)
            throws ServletException, IOException {

        String email =
            req.getParameter("email");

        String password =
            req.getParameter("password");

        try {

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(
                    "SELECT * FROM users WHERE email=?"
                );

            ps.setString(1, email);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){

                String dbPassword =
                    rs.getString("password");

                if(BCrypt.checkpw(password, dbPassword)){

                    HttpSession session =
                        req.getSession();

                    session.setAttribute(
                        "user_id",
                        rs.getInt("id")
                    );

                    session.setAttribute(
                        "user_name",
                        rs.getString("name")
                    );

                    res.sendRedirect(
                        "DashboardServlet"
                    );

                } else {

                    req.setAttribute(
                        "error",
                        "Invalid credentials"
                    );

                    req.getRequestDispatcher(
                        "login.jsp"
                    ).forward(req, res);
                }

            } else {

                req.setAttribute(
                    "error",
                    "User does not exist. Please sign up."
                );

                req.getRequestDispatcher(
                    "login.jsp"
                ).forward(req, res);
            }

        } catch(Exception e){

            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        res.sendRedirect("login.jsp");
    }
}