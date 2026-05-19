<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>Edit Expense</title>

    <meta charset="UTF-8">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/addEdit.css?v=1">

</head>

<body>

<div class="container">

    <div class="header">

        <h1>Update your Existing Expense</h1>

        <p>
            Keep your expense records accurate by updating this transaction's details.
        </p>

    </div>

    <div class="form-card">

        <form action="UpdateExpenseServlet"
              method="post">

            <input type="hidden"
                   name="id"
                   value="<%= request.getAttribute("id") %>">

            <!-- ROW -->
            <div class="row">

                <!-- AMOUNT -->
                <div class="field">

                    <label>Amount</label>

                    <input type="number"
                           name="amount"
                           step="100"
                           value="<%= request.getAttribute("amount") %>"
                           required>

                </div>

                <!-- DATE -->
                <div class="field">

                    <label>Date</label>

                    <input type="date"
                           name="date"
                           value="<%= request.getAttribute("date") %>"
                           required>

                </div>

            </div>

            <!-- CATEGORY -->
            <div class="field">

                <label>Category</label>

                <select name="category" required>

                    <option value="">Select a category</option>

                    <option value="Groceries"
                        <%= "Groceries".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Groceries
                    </option>

                    <option value="Food"
                        <%= "Food".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Food
                    </option>

                    <option value="Transport"
                        <%= "Transport".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Transport
                    </option>

                    <option value="Entertainment"
                        <%= "Entertainment".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Entertainment
                    </option>

                    <option value="Utilities"
                        <%= "Utilities".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Utilities
                    </option>

                    <option value="Health"
                        <%= "Health".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Health
                    </option>

                    <option value="Shopping"
                        <%= "Shopping".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Shopping
                    </option>

                    <option value="Other"
                        <%= "Other".equals(request.getAttribute("category")) ? "selected" : "" %>>
                        Other
                    </option>

                </select>

            </div>

            <!-- DESCRIPTION -->
            <div class="field">

                <label>Description</label>

                <textarea name="description"
                          rows="3"
                          placeholder="What was this for?"><%= request.getAttribute("description") %></textarea>

            </div>

            <!-- BUTTONS -->
            <div class="actions">

                <button type="button"
                        class="cancel-btn"
                        onclick="window.location.href='ExpensesServlet'">

                    Cancel

                </button>

                <button type="submit"
                        class="save-btn">

                    Update Expense

                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>