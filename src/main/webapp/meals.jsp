<%@ page import="main.Path" %>
<%@ page import="main.db.entities.Dish" %>
<%@ page import="java.util.List" %>
<%@ page import="main.db.dao.DishesDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ресторан</title>
    <link href="css/startStyles.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
    List<Dish> dishes = new DishesDAO().getAllDishes();
%>


    <div id="header">
        <table>
            <tr><td><a href="<%=Path.PAGE__START%>" class="logo" id="soloLogo">dlvr.</a></td></tr>
        </table>
    </div>

    <div class="floatingMenu" id="floatingMeals">
        <table class="tableClass">
            <%
                for (Dish d : dishes) {
            %>
            <tr class="mealsRow">
                <td><img src="<%=d.getPic()%>" class="images" alt="Food image"></td>
                <td><%=d.getName()%></td>
                <td><%=d.getPrice()%> UAH</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>