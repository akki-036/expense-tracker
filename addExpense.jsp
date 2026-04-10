<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String today = new java.text.SimpleDateFormat("yyyy-MM-dd")
        .format(new java.util.Date());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Expense</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/addExpense.css">
</head>
<body>

<div class="container">

    <div class="header">
    <h1>Record a New Expense</h1>
    <p>Track your spending by adding a new transaction to your account.</p>
    </div>

    <div class="form-card">

        <form action="AddExpenseServlet" method="post">

            <!-- AMOUNT + DATE -->
            <div class="row">

                <div class="field">
                    <label>Amount</label>
                    <input type="number"
                           name="amount"
                           step="100"
                           placeholder="₹ 0.00"
                           required>
                </div>

                <div class="field">
                    <label>Date</label>
                    <input type="date"
                           name="date"
                           value="<%= today %>"
                           required>
                </div>

            </div>

            <!-- CATEGORY -->
            <label>Category</label>
            <select name="category" required>
                <option value="">Select a category</option>
                <option value="Groceries">Groceries</option>
                <option value="Food">Takeaway/Dining</option>
                <option value="Transport">Transport</option>
                <option value="Entertainment">Entertainment</option>
                <option value="Utilities">Utilities</option>
                <option value="Health">Health</option>
                <option value="Shopping">Shopping</option>
                <option value="Other">Other</option>
            </select>

            <!-- DESCRIPTION -->
            <label>Description</label>
            <textarea name="description"
                      placeholder="What was this for?"
                      rows="3"></textarea>

            <!-- BUTTONS -->
            <div class="actions">

                <button type="button"
                        class="cancel-btn"
                        onclick="window.location.href='DashboardServlet'">
                    Cancel
                </button>

                <button type="submit" class="save-btn">
                    Save Expense
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>