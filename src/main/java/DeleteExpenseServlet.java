import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/DeleteExpenseServlet")
public class DeleteExpenseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            res.sendRedirect("login.html");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        String idStr = req.getParameter("id");

        if (idStr == null || idStr.isEmpty()) {
            res.sendRedirect("ExpensesServlet");
            return;
        }

        int id = 0;

        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            // invalid ID
            res.sendRedirect("ExpensesServlet");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String query = "DELETE FROM expenses WHERE id = ? AND user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();

            if (rows == 0) {
                System.out.println("⚠️ Delete failed or unauthorized access");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔁 Redirect back
        res.sendRedirect("ExpensesServlet");
    }
}