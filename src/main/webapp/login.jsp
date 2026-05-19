<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css?v=2">
</head>
<body class="auth-body">

<div class="auth-container">
    <div class="logo">
        <img src="images/bag.webp" alt="Bag">
    </div>
    <h1>Welcome back</h1>
    <p class="subtitle">
        Enter your details to access your ledger.
    </p>

    <%
    String error =
        (String) request.getAttribute("error");
    if(error != null){
    %>

    <div class="error-message">
        <%= error %>
    </div>
    <% } %>

    <form action="LoginServlet"
          method="post">

        <input type="text"
               name="email"
               placeholder="Johndoe@example.com"
               required>

        <input type="password"
               name="password"
               placeholder="Password"
               required>

        <button type="submit">
            Sign In
        </button>

    </form>
    <p class="switch">
        Don't have an account?
        <a href="register.jsp">
            Create one
        </a>
    </p>
</div>
</body>
</html>