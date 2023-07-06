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
        try {
        //create connection to database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstonefoodreview", "root", "admin");
        
        Statement stmt = con.createStatement();
        
        ResultSet rs = stmt.executeQuery("SELECT DISTINCT MealName FROM Meals");
        
        %>
        
        <form method="post">
        <div class="alignItems">
            <label>Enter Your Name</label>
            <input type="textbox" name="name">
            
            <label>Select a Meal to review</label>
            <select name="meal">
                <%
                while (rs.next()){  
                    %><option value="<%out.print(rs.getString("MealName"));%>"><%out.print(rs.getString("MealName"));%></option><%
                }
                %>
            </select>
            
            <label>Select Your Score</label>
            <select name="score">
                <%
                    for (int x = 10; x > 0; x--)
                    {
                        %><option value="<%out.print(x);%>"><%out.print(x);%></option><%
                    }
                %>
            </select>
            
            <label>Enter in your Review!</label>
            <input type="textbox" name="review"><br>
            
            <input type="submit" value="Submit">
            
            <%
            
            String name = "";
            String meal = "";
            int score = 0;
            String review = "";

            if (request.getMethod().equalsIgnoreCase("post"))
            {
                name  = request.getParameter("name");
                meal = request.getParameter("meal");
                score = Integer.parseInt(request.getParameter("score"));
                review = request.getParameter("review");
            %>
            
            <!-- thanks the user and notifies them that their review has been added to the review records -->
            <p><%out.println("Thank You " + name);%></p>
            
            <p><%out.println("The meal that you reviewed (" + meal + ") shalled be added to our review records!");%></p>
            
            <%
            }//end if
            %>
        </div>
        </form>
        <%
        
        rs = stmt.executeQuery("SELECT * FROM Reviews");
        
        ArrayList <Integer> reviewSize = new ArrayList<>();
        
        while (rs.next())
        {
            reviewSize.add(rs.getInt("reviewID"));
        }
        
        if (!name.isEmpty() && !meal.isEmpty() && !review.isEmpty()) 
        {
            stmt.executeUpdate("INSERT INTO reviews (ReviewID, ReviewName, MealName, ReviewScore, Review) VALUES (" + (reviewSize.size() + 1) + ", '" + name + "', '" + meal + "', " + score + ", '" + review + "')");
        }

        // stmt.executeUpdate("INSERT INTO meals(MealName, RestaurantName, RestaurantAddress, Price, City)
            
        con.close();

            }catch (Exception e){
                out.println(e);
            }//end catch

        %>
    </body>
</html>
