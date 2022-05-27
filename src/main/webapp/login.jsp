<%@ page import="main.Path" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ресторан</title>
    <link href="css/startStyles.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect(Path.PAGE__USER_PAGE);
    }
%>

    <div id="header">
        <table>
            <tr>
                <td><a href="http://localhost:8080/final/" class="logo">dlvr.</a></td>
                <td><button id="login" onclick="document.location.href='<%=Path.PAGE__REGISTRATION%>'">Реєстрація</button></td>
            </tr>
        </table>
    </div>
    <div class="floatingMenu">
        <form action="controller" method="post" onsubmit="validate()">
            <input type="hidden" name="command" value="login"/>
            <table>
                <%
                    if (session.getAttribute("failedToLogin") != null) {
                %>
                <tr><td id="wrongLogin">Неправильно введене ім'я, або пароль</td></tr>
                <%
                    }
                %>
                <tr><td><input type="text" name="username" placeholder="Username" required></td></tr>
                <tr><td><input type="password" name="password" placeholder="Password" required></td></tr>
                <tr><td><input id="submitButton" type="submit" value="Увійти"></td></tr>
            </table>
        </form>
    </div>
</body>
</html>