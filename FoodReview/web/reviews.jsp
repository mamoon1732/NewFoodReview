<%@page import="foodreview.Meals"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Twin Cities Food Review</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body style="text-align: center">
        <header>
        <span class="logos-container">
                <a href="index.html">
                    <img src="tc.jpg" alt="logo of Twin Cities Food Reviews" class="logo">
                </a>
            <i class="titleText">Twin Cities Food Review</i>
                <a href="index.html">
                    <img src="tc.jpg" alt="logo of Twin Cities Food Reviews" class="logo">
                </a>
        </span>
        </header>
        
            <nav class="navbar navbar-expand-sm bg-warning">
                <div class="container-fluid">
                    <!-- navbar links to home tab, book review tab, and comic review tab -->
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="index.html"><i class="bi-house-fill"></i>Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="submit.jsp"><i class="bi-people-fill"></i>Leave a Food Review!</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="new.jsp"><i class="bi-people-fill"></i>Leave a New Review!</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp"><i class="bi-people-fill"></i>Can't decide what to eat?</a>
                        </li>
                    </ul>
                </div>
            </nav>
        
        <% 
            String mealName = request.getParameter("mealName"); 

        try {
        //create connection to database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstonefoodreview", "root", "admin");
        
        Statement stmt = con.createStatement();
        
        ResultSet rs = stmt.executeQuery("SELECT * FROM Reviews WHERE MealName = '" + mealName + "'");
        
        %><h1 style="font-size: 70px; margin-bottom: 20px;"><%out.println(mealName);%> reviews!</h1>
        
        <div class="menu-top">
            <div class="reviewName-top"><strong>Reviewer's Name</strong></div>
            <div class="reviewScore-top"><strong>Reviewer's Score</strong></div>
            <div class="reviewText-top"><strong>Reviewer's Review</strong></div>
        </div>
        <hr>
        <%
        while (rs.next()){
        %>
        <div class="menu">
            <div class="reviewName"><strong><%=rs.getString("reviewName")%></strong></div>
            <div class="reviewScore"><strong><%=rs.getInt("reviewScore")%>/10</strong></div>
            <div class="reviewText"><strong><%=rs.getString("review")%></strong></div>
        </div>
        <hr>
        <%
        }

        
        con.close();

            }catch (Exception e){
                out.println(e);
            }//end catch
        %>
        
    </body>
</html>
