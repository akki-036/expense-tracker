# Expense Tracker
A web-based Expense Tracker application developed using Java Servlets, JDBC, MySQL, JSP, CSS, JavaScript and Maven. The application allows users to manage daily expenses efficiently with CRUD operations, authentication, filtering, dashboard analytics, and responsive UI. 

---
## Features
- User registration and login authentication
- Session-based authentication
- Create expenses
- Read expenses
- Update expenses
- Delete expenses
- Filter expenses by:
  - category
  - amount
  - date
- Dashboard with:
  - total expenses
  - monthly expenses
  - recent transactions
  - category summary
  - monthly spending chart
- Responsive modern UI
- Secure password hashing using BCrypt
---

## Tech Stack
### Frontend
- JSP
- CSS3
- JavaScript
- Chart.js

### Backend
- Java Servlets
- JDBC
- BCrypt Password Hashing

### Database
- MySQL

### Build Tool
- Maven

### Server
- Apache Tomcat

---
## Project Structure

```text
ExpenseTracker/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── webapp/
│   │       ├── css/
│   │       ├── WEB-INF/
│   │           └── web.xml
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       ├── dashboard.jsp
│   │       ├── expenses.jsp
│   │       ├── addExpense.jsp
│   │       └── editExpense.jsp
├── pom.xml
├── .gitignore

```
---
## Setup & Run

1. Clone the repository:
```bash
git clone https://github.com/akki-036/expense-tracker.git
```

2. Configure MySQL:
Create a MySQL database and update database credentials inside: 
```bash
DBConnection.java
```

3. Build the project:
```bash
mvn clean install
```

4. Deploy on Tomcat:
Deploy the generated WAR file from
```bash
target/expense-tracker.war
```
to Apache Tomcat.

---
## Future Improvements

* Dark mode
* Budget planner
* Expense analytics
* Export reports
* Profile management
