<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="main.Path" %>
<%@page import="main.commands.CommandNames" %>
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
            <tr>
                <td><a href="${Path.PAGE__START}" class="logo">dlvr.</a></td>
                <td>
                    <form action="controller">
                        <button name="command" value="${CommandNames.COMMAND__SHOW_LOGIN}">
                            Особистий кабінет
                        </button>
                    </form>
                </td>
            </tr>
        </table>
    </div>

    <div class="floating-div">
        <table>
            <tr class="floating-row-s">
                <td colspan="30">Замовлення №:${requestScope.order.id}</td>
                <td colspan="30">Ціна ${requestScope.order.price}</td>
            </tr>
            <tr class="floating-row-s">
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    Місто
                </td>
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    Вулиця
                </td>
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    Будинок
                </td>
                <c:if test="${requestScope.address.apartmentNumber != null}">
                    <td colspan="15">Квартира</td>
                </c:if>
            </tr>
            <tr class="floating-row-s">
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    ${requestScope.address.city}
                </td>
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    ${requestScope.address.street}
                </td>
                <td colspan="${requestScope.address.apartmentNumber != null ? 15 : 20}">
                    ${requestScope.address.houseNumber}
                </td>
                <c:if test="${requestScope.address.apartmentNumber != null}">
                    <td colspan="15">${requestScope.address.apartmentNumber}</td>
                </c:if>
            </tr>
            <tr class="floating-row-s">
                <td colspan="30">Номер картки</td>
                <td colspan="30">Термін картки</td>
            </tr>
            <tr class="floating-row-s">
                <td colspan="30">${requestScope.payment.number.substring(0, requestScope.payment.number.length()/2)}********</td>
                <td colspan="30">${requestScope.payment.till.substring(0, requestScope.payment.till.length()/2)}/**</td>
            </tr>
            <c:forEach items="${requestScope.dishes}" var="d" varStatus="loop">
            <tr class="floating-row-l">
                <td colspan="24"><img src="data:image/jpeg;base64, ${d.pic64}" class="image" alt="Food image"></td>
                <td colspan="12">${d.name}</td>
                <td colspan="12">${d.price} UAH</td>
                <td colspan="12">Кількість: ${requestScope.orderedDishes.get(loop.index).dishAmount}</td>
            </tr>
            </c:forEach>
            <tr class="floating-row">
                <td colspan="60">
                    <input class="floating-button-danger" type="submit" value="Відмінити замовлення" form="cancelOrder">
                </td>
            </tr>
        </table>
        <form id="cancelOrder" action="controller" method="post">
            <input type="hidden" name="command" value="${CommandNames.COMMAND__CANCEL_ORDER}"/>
            <input type="hidden" name="orderId" value="${requestScope.order.id}"/>
        </form>
    </div>
    <table style="height: 30vh">
        <tr>
            <td>
            </td>
        </tr>
    </table>
</body>
</html>