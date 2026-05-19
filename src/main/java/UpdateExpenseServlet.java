import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/UpdateExpenseServlet")

public class UpdateExpenseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse res)
            throws ServletException, IOException {

        try {

            Connection con =
                DBConnection.getConnection();

            int id =
                Integer.parseInt(req.getParameter("id"));

            double amount =
                Double.parseDouble(req.getParameter("amount"));

            String category =
                req.getParameter("category");

            String description =
                req.getParameter("description");

            String date =
                req.getParameter("date");

            PreparedStatement ps =
                con.prepareStatement(
                    "UPDATE expenses SET amount=?, category=?, description=?, date=? WHERE id=?"
                );

            ps.setDouble(1, amount);
            ps.setString(2, category);
            ps.setString(3, description);
            ps.setString(4, date);
            ps.setInt(5, id);

            ps.executeUpdate();

            res.sendRedirect("ExpensesServlet");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}