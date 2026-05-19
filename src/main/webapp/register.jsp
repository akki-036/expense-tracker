<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Register</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/register.css?v=2">

</head>

<body>

<div class="auth-wrapper">

    <!-- ICON -->
    <div class="logo">
        <img src="images/bag.webp">
    </div>

    <h1>Create account</h1>

    <p class="subtitle">
        Start managing your ledger today.
    </p>

    <!-- ERROR -->
    <%
    String error =
        (String) request.getAttribute("error");

    if(error != null){
    %>

    <div class="error-message">
        <%= error %>
    </div>

    <% } %>

    <!-- FORM CARD -->
    <div class="form-card">

        <form action="RegisterServlet"
              method="post">

            <label>Name</label>

            <input type="text"
                   name="name"
                   placeholder="John Doe"
                   required>

            <label>Email</label>

            <input type="text"
                   name="email"
                   placeholder="johndoe@example.com"
                   required>

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Password"
                   required>

            <button type="submit">
                Create Account
            </button>

        </form>

    </div>

    <p class="switch">

        Already have an account?

        <a href="login.jsp">
            Sign in
        </a>

    </p>

</div>

</body>
</html>