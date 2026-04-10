import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ExpensesServlet")
public class ExpensesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);

        if(session == null || session.getAttribute("user_id") == null){
            res.sendRedirect("login.html");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        List<Map<String, Object>> expenses = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String query = "SELECT * FROM expenses WHERE user_id=?";
            List<Object> params = new ArrayList<>();
            params.add(userId);

            // FILTERS
            if(req.getParameter("category") != null && !req.getParameter("category").isEmpty()){
                query += " AND category=?";
                params.add(req.getParameter("category"));
            }

            if(req.getParameter("minAmount") != null && !req.getParameter("minAmount").isEmpty()){
                query += " AND amount >= ?";
                params.add(Double.parseDouble(req.getParameter("minAmount")));
            }

            if(req.getParameter("maxAmount") != null && !req.getParameter("maxAmount").isEmpty()){
                query += " AND amount <= ?";
                params.add(Double.parseDouble(req.getParameter("maxAmount")));
            }

            try {
                if(req.getParameter("fromDate") != null && !req.getParameter("fromDate").isEmpty()){
                    query += " AND date >= ?";
                    params.add(java.sql.Date.valueOf(req.getParameter("fromDate")));
                }

                if(req.getParameter("toDate") != null && !req.getParameter("toDate").isEmpty()){
                    query += " AND date <= ?";
                    params.add(java.sql.Date.valueOf(req.getParameter("toDate")));
                }
            } catch(Exception ignored) {}

            query += " ORDER BY date DESC";

            PreparedStatement ps = con.prepareStatement(query);

            for(int i = 0; i < params.size(); i++){
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Map<String, Object> row = new HashMap<>();

                row.put("id", rs.getInt("id"));
                row.put("date", rs.getDate("date"));
                row.put("category", rs.getString("category"));
                row.put("description", rs.getString("description"));
                row.put("amount", rs.getDouble("amount"));

                expenses.add(row);
            }

            req.setAttribute("expenses", expenses);
            req.getRequestDispatcher("expenses.jsp").forward(req, res);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}