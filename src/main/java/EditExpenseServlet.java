import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/EditExpenseServlet")

public class EditExpenseServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        try {

            int id =
                Integer.parseInt(req.getParameter("id"));

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(
                    "SELECT * FROM expenses WHERE id=?"
                );

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                req.setAttribute("id",
                    rs.getInt("id"));

                req.setAttribute("amount",
                    rs.getDouble("amount"));

                req.setAttribute("category",
                    rs.getString("category"));

                req.setAttribute("description",
                    rs.getString("description"));

                req.setAttribute("date",
                    rs.getDate("date"));

                req.getRequestDispatcher("editExpense.jsp")
                    .forward(req, res);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}