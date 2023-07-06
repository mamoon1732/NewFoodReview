<%@page import="foodreview.Meals"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        //create connection to database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstonefoodreview", "root", "admin");
        
        Statement stmt = con.createStatement();
        
        ResultSet rs = stmt.executeQuery("SELECT DISTINCT RestaurantName FROM Meals");
        
        ArrayList <String> restaurantNames = new ArrayList<>();
        
        while (rs.next()){
            restaurantNames.add(rs.getString("restaurantName"));
        }
        
        Meals meal = new Meals();
    
        //string to hold selected author from index.html page
        meal.setRestaurantName(request.getParameter("restaurantName"));
        
        rs = stmt.executeQuery("SELECT * FROM Meals WHERE RestaurantName = '" + meal.getRestaurantName() + "'");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Twin Cities Food Review</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
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
        ArrayList <String> meals = new ArrayList<>();
        ArrayList <Double> price = new ArrayList<>();
        
        while (rs.next())
        {
            meal.setAddress(rs.getString("restaurantAddress"));
            meal.setCity(rs.getString("city"));
            meals.add(rs.getString("mealName"));
            price.add(rs.getDouble("price"));
        }
        
        ArrayList <String> reviewer = new ArrayList<>();
        ArrayList <Integer> score = new ArrayList<>();
        
        for (int x = 0; x < meals.size(); x++)
        {
            rs = stmt.executeQuery("SELECT * FROM Reviews WHERE mealName = '" + meals.get(x) + "'");
            
            while (rs.next())
            {
                reviewer.add(rs.getString("ReviewName"));
                score.add(rs.getInt("ReviewScore"));
            }
        }
        
        for (int x = 0; x < restaurantNames.size(); x++)
        {
            if (meal.getRestaurantName().equalsIgnoreCase(restaurantNames.get(x)))
            {
        %><section>
            <div class="alignItems">
                <h2 style="margin-top: 20px;">Restaurant Details</h2>
                <div class="myboxtwo">
                    <img src="restaurants/<%=meal.getRestaurantName().replaceAll("\\s", "")%>.jpg" alt="image of <%=restaurantNames.get(x)%>" class="innerFood"><%
            }
        }
                    %><h2><%out.println(meal.getRestaurantName());%></h2><%
                    %><h2><%out.println(meal.getAddress());%></h2><%
                    %><h2><%out.println(meal.getCity());%></h2>
                </div>
            </div>
            </section><%
        
        %><section>
            <div class="alignItems">
                <h2 style="margin-top: 20px;">List of Reviewed Meals from <%=meal.getRestaurantName()%></h2><%

                for (int x = 0; x < meals.size(); x++)
                {
                %><div class="myboxthree">
                    <img src="<%=meals.get(x).replaceAll("\\s", "")%>.jpg" alt="image of <%=meals.get(x)%>" class="innerFood"><%

                    %><h2><%out.println(meals.get(x));%></h2><%
                    %><h2><%out.println("$" + price.get(x));%></h2><%

                    %><a href="reviews.jsp?mealName=<%=meals.get(x)%>">Click Here to see reviews for this meal!</a><br>
                    <a href="own.jsp?mealSelect=<%=meals.get(x)%>">Click Here to review this meal!</a>
                </div><%
                } 
            %></div><%
        %></section><%
        //close connection
            con.close();

            }catch (Exception e){
                out.println(e);
            }//end catch
        %>
    </body>
</html>
