import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*; 
import java.util.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        try {
            Connection con = DBConnection.getConnection();

            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("user_id") == null) {
                res.sendRedirect("login.html");
                return;
            }

            int userId = (int) session.getAttribute("user_id");

            // ✅ MONTHLY TOTAL
            PreparedStatement psMonth = con.prepareStatement(
                "SELECT SUM(amount) FROM expenses WHERE user_id=? AND MONTH(date)=MONTH(CURDATE()) AND YEAR(date)=YEAR(CURDATE())"
            );
            psMonth.setInt(1, userId);
            ResultSet rsMonth = psMonth.executeQuery();

            double monthlyTotal = 0;
            if (rsMonth.next()) {
                monthlyTotal = rsMonth.getDouble(1);
            }

            // ✅ ALL TIME TOTAL
            PreparedStatement psAll = con.prepareStatement(
                "SELECT SUM(amount) FROM expenses WHERE user_id=?"
            );
            psAll.setInt(1, userId);
            ResultSet rsAll = psAll.executeQuery();

            double total = 0;
            if (rsAll.next()) {
                total = rsAll.getDouble(1);
            }

            // ✅ COUNT
            PreparedStatement psCount = con.prepareStatement(
                "SELECT COUNT(*) FROM expenses WHERE user_id=?"
            );
            psCount.setInt(1, userId);
            ResultSet rsCount = psCount.executeQuery();

            int count = 0;
            if (rsCount.next()) {
                count = rsCount.getInt(1);
            }

            // ✅ EXPENSES LIST (IMPORTANT)
            PreparedStatement psList = con.prepareStatement(
                "SELECT * FROM expenses WHERE user_id=? ORDER BY date DESC"
            );
            psList.setInt(1, userId);
            ResultSet rs = psList.executeQuery();

            List<Map<String, Object>> expenses = new ArrayList<>();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();

                row.put("id", rs.getInt("id"));
                row.put("date", rs.getDate("date"));
                row.put("category", rs.getString("category"));
                row.put("description", rs.getString("description"));
                row.put("amount", rs.getDouble("amount"));

                expenses.add(row);
            }

            // ✅ SEND EVERYTHING
            req.setAttribute("monthlyTotal", monthlyTotal);
            req.setAttribute("total", total);
            req.setAttribute("count", count);
            req.setAttribute("expenses", expenses);

            req.getRequestDispatcher("/dashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}