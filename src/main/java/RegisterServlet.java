import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse res)
            throws ServletException, IOException {

        String name =
            req.getParameter("name");

        String email =
            req.getParameter("email");

        String password =
            req.getParameter("password");

        try {

            Connection con =
                DBConnection.getConnection();

            // CHECK IF USER EXISTS
            PreparedStatement check =
                con.prepareStatement(
                    "SELECT * FROM users WHERE email=?"
                );

            check.setString(1, email);

            ResultSet rs =
                check.executeQuery();

            if(rs.next()){

                req.setAttribute(
                    "error",
                    "User already exists. Please login."
                );

                req.getRequestDispatcher(
                    "register.jsp"
                ).forward(req, res);

            } else {

                PreparedStatement ps =
                    con.prepareStatement(
                        "INSERT INTO users(name,email,password) VALUES(?,?,?)"
                    );

                ps.setString(1, name);
                ps.setString(2, email);
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                ps.setString(3, hashedPassword);
                ps.executeUpdate(); 
                res.sendRedirect("login.jsp");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}