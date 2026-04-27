<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Expenses</title>
    <link rel="stylesheet" href="css/expenses.css">
</head>
<body>

<div class="main">

    <!-- TOPBAR -->
    <div class="topbar">
        <h1>All Expenses</h1>

        <button class="add-btn"
            onclick="window.location.href='addExpense.jsp'">
            + Add Expense
        </button>
    </div>

    <!-- FILTERS -->
    <form method="get" action="ExpensesServlet" class="filters">

        <input type="date" name="fromDate">
        <input type="date" name="toDate">

        <select name="category">
            <option value="">All Categories</option>
            <option>Groceries</option>
            <option>Food</option>
            <option>Transport</option>
            <option>Entertainment</option>
            <option>Utilities</option>
            <option>Health</option>
            <option>Shopping</option>
            <option>Other</option>
        </select>

        <input type="number" name="minAmount" placeholder="Min ₹">
        <input type="number" name="maxAmount" placeholder="Max ₹">

        <button type="submit">Apply</button>

        <button type="button"
            onclick="window.location.href='ExpensesServlet'">
            Clear
        </button>

    </form>

    <!-- TABLE -->
    <div class="table">
        <h3>All Transactions</h3>

        <table>
            <tr>
                <th>Date</th>
                <th>Description</th>
                <th>Category</th>
                <th>Amount</th>
                <th>Action</th>
            </tr>

            <%
            List<Map<String, Object>> expenses =
                (List<Map<String, Object>>) request.getAttribute("expenses");

            if(expenses != null && !expenses.isEmpty()) {
                for(Map<String, Object> e : expenses) {
            %>

            <tr>
                <td><%= e.get("date") %></td>
                <td><%= e.get("description") %></td>
                <td><%= e.get("category") %></td>
                <td>₹ <%= String.format("%.2f", e.get("amount")) %></td>

                <td>
                    <form action="DeleteExpenseServlet" method="post">
                        <input type="hidden" name="id" value="<%= e.get("id") %>">

                        <button type="button" class="delete-btn"
                                onclick="openModal(this.closest('form'))">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>

            <%
                }
            } else {
            %>

            <tr>
                <td colspan="5" style="text-align:center;">
                    No expenses found.
                </td>
            </tr>

            <% } %>
        </table>
    </div>

</div>

<div id="deleteModal" class="modal">
    <div class="modal-box">
        <h3>Delete Expense</h3>
        <p>Are you sure you want to delete this expense?</p>

        <div class="modal-actions">
            <button onclick="closeModal()">Cancel</button>
            <button id="confirmDelete">Delete</button>
        </div>
    </div>
</div>

<!-- SCRIPT -->
<script>
let deleteForm = null;

function openModal(form) {
    deleteForm = form;
    document.getElementById("deleteModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("deleteModal").style.display = "none";
}

window.onload = function() {
    document.getElementById("confirmDelete").onclick = function() {
        if(deleteForm) deleteForm.submit();
    };
};

// click outside modal to close
window.onclick = function(e) {
    let modal = document.getElementById("deleteModal");
    if(e.target === modal){
        closeModal();
    }
};
</script>

</body>
</html>