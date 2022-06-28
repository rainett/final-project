<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="main.db.dao.DishesSorting" %>
<%@ page import="main.commands.CommandName" %>
<%@page import="main.Path" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>final</title>
    <link href="css/startStyles.css" rel="stylesheet" type="text/css">
</head>
<body>

    <div id="header">
        <table>
            <tr><td><a href="${Path.PAGE__START}" class="logo">dlvr.</a></td></tr>
        </table>
    </div>

    <div class="floating-div">
        <table>
            <tr class="floating-row">
                <td colspan="4">
                    <div class="dropdown">
                        <button disabled class="dropbtn">Сортувати</button>
                        <div class="dropdown-content">
                            <form action="controller">
                                <input type="hidden" name="command" value="${CommandName.COMMAND__SHOW_EDIT_DISHES}">
                                <button name="sorting" value="${DishesSorting.SORT__PRICE_DESC}">
                                    Від дорожчих
                                </button>
                                <button name="sorting" value="${DishesSorting.SORT__PRICE_ASC}">
                                    Від дешевих
                                </button>
                                <button name="sorting" value="${DishesSorting.SORT__BY_ALPHABET}">
                                    За алфавітом
                                </button>
                            </form>
                        </div>
                    </div>
                </td>
            </tr>
            <tr class="floating-row">
                <td colspan="4">
                    <form action="controller">
                        <button class="floating-button" name="command"
                                value="${CommandName.COMMAND__SHOW_NEW_DISH}">
                            Нова страва
                        </button>
                    </form>
                </td>
            </tr>
            <c:forEach items="${requestScope.dishes}" var="d" varStatus="loop">
                <tr class="floating-row-l-clickable" onclick="document.forms['updateForm${d.id}'].submit();" >
                    <td colspan="2">
                        <form action="controller" id="updateForm${d.id}">
                            <img src="data:image/jpeg;base64, ${requestScope.photos.get(loop.index).pic64}"
                                 class="image" alt="Food image">
                            <input type="hidden" name="command"
                                   value="${CommandName.COMMAND__SHOW_UPDATE_DISH}">
                            <input type="hidden" name="dishId"
                                   value="${d.id}">
                        </form>
                    </td>
                    <td>${d.name}</td>
                    <td>${d.price} UAH</td>
                </tr>
            </c:forEach>
            <tr class="floating-row-s"></tr>
        </table>
    </div>
    <table style="height: 30vh">
        <tr>
            <td>
            </td>
        </tr>
    </table>
</body>
</html>