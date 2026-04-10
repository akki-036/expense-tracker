import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class AddExpenseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            res.sendRedirect("login.html");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        try {
            double amount = Double.parseDouble(req.getParameter("amount"));
            String category = req.getParameter("category");
            String description = req.getParameter("description");
            String date = req.getParameter("date");

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO expenses(user_id, amount, category, description, date) VALUES (?, ?, ?, ?, ?)"
            );

            ps.setInt(1, userId);
            ps.setDouble(2, amount);
            ps.setString(3, category);
            ps.setString(4, description);
            ps.setDate(5, java.sql.Date.valueOf(date));

            ps.executeUpdate();

            res.sendRedirect("DashboardServlet");

        } catch(Exception e) {
            e.printStackTrace();

            res.getWriter().println("<h3>Error adding expense</h3>");
        }
    }
}