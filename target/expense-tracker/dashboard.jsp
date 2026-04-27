<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<%

// ✅ GET VALUES FROM SERVLET
Double monthlyTotal = (request.getAttribute("monthlyTotal") != null)
    ? (Double) request.getAttribute("monthlyTotal") : 0.0;

Double total = (request.getAttribute("total") != null)
    ? (Double) request.getAttribute("total") : 0.0;

Integer count = (request.getAttribute("count") != null)
    ? (Integer) request.getAttribute("count") : 0;

List<Map<String, Object>> expenses =
    (List<Map<String, Object>>) request.getAttribute("expenses");


// ✅ MONTHLY CHART DATA
Map<Integer, Double> monthMap = new LinkedHashMap<>();

for(int i = 0; i < 12; i++) {
    monthMap.put(i, 0.0);
}

if(expenses != null){
    for(Map<String,Object> e : expenses){

        java.sql.Date date = (java.sql.Date)e.get("date");
        double amt = (double)e.get("amount");

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        int month = cal.get(Calendar.MONTH);

        monthMap.put(month, monthMap.get(month) + amt);
    }
}

List<String> labels = new ArrayList<>();
List<Double> values = new ArrayList<>();

String[] monthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};

for(int i = 0; i < 12; i++){
    labels.add(monthNames[i]);
    values.add(monthMap.get(i));
}

%>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
    <h2>Ledger</h2>

    <a href="DashboardServlet" class="active">Dashboard</a>
    <a href="ExpensesServlet">Expenses</a>

    <div class="bottom">
        <p> Signed in as<br>
        <b>
        <%= (session.getAttribute("user_name") != null)
            ? session.getAttribute("user_name")
            : "User" %>
        </b>
        </p>
        <a href="login.html">Logout</a>
    </div>
</div>

<div class="main">

    <!-- TOPBAR -->
    <div class="topbar">
        <button class="menu-btn" onclick="toggleSidebar()">
            <span></span><span></span><span></span>
        </button>

        <h1>Overview</h1>

        <button class="add-btn"
            onclick="window.location.href='addExpense.jsp'">
            + Add Expense
        </button>
    </div>

    <!-- ✅ CARDS -->
    <div class="cards">

        <!-- MONTHLY -->
        <div class="card">
            <p>This Month</p>
            <h2>₹ <%= String.format("%.2f", monthlyTotal) %></h2>
        </div>

        <!-- ALL TIME -->
        <div class="card">
            <p>All Time</p>
            <h2>₹ <%= String.format("%.2f", total) %></h2>
        </div>

        <!-- COUNT -->
        <div class="card">
            <p>Transactions</p>
            <h2><%= count %></h2>
        </div>

    </div>

    <!-- GRID -->
    <div class="grid">

        <!-- CHART -->
        <div class="chart-card">
            <h3>Spending History</h3>
            <canvas id="chart"></canvas>
        </div>

        <!-- CATEGORY -->
        <div class="category-card">
            <h3>Categories</h3>

            <%
            Map<String, Double> categoryMap = new HashMap<>();

            if(expenses != null){
                for(Map<String,Object> e : expenses){
                    String cat = (String)e.get("category");
                    double amt = (double)e.get("amount");

                    categoryMap.put(cat,
                        categoryMap.getOrDefault(cat,0.0)+amt);
                }
            }

            for(String cat : categoryMap.keySet()){
            %>

            <div class="cat-item">
                <span><%= cat %></span>
                <span>₹ <%= String.format("%.2f", categoryMap.get(cat)) %></span>
            </div>

            <% } %>
        </div>

    </div>

    <!-- TRANSACTIONS -->
    <div class="transactions">

        <div class="txn-header">
            <h3>Recent Transactions</h3>

            <button class="view-all-btn"
                onclick="window.location.href='ExpensesServlet'">
                View All →
            </button>
        </div>

        <% if(expenses != null && !expenses.isEmpty()){
            int limit = Math.min(7, expenses.size());
            for(int i = 0; i < limit; i++){
                Map<String,Object> e = expenses.get(i);
        %>

        <div class="txn">
            <div>
                <b><%= e.get("description") %></b><br>
                <small>
                    <%= e.get("category") %> • <%= e.get("date") %>
                </small>
            </div>

            <div class="amount">
                ₹ <%= String.format("%.2f", e.get("amount")) %>
            </div>
        </div>

        <% }} else { %>
            <p>No transactions yet.</p>
        <% } %>

    </div>
</div>

<script>
window.onload = function() {

    const labels = [
        <% for(String m : labels) { %>
            "<%= m %>",
        <% } %>
    ];

    const data = [
        <% for(Double v : values) { %>
            <%= v %>,
        <% } %>
    ];

    const ctx = document.getElementById('chart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Spending',
                data: data,
                backgroundColor: '#b85c38'
            }]
        }
    });
};

function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("active");
}
</script>

</body>
</html>