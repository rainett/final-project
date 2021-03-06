package main.commands.order;

import main.commands.Command;
import main.commands.CommandNames;
import main.db.dao.DishesDAO;
import main.db.entities.Dish;
import main.db.entities.Order;
import main.db.entities.OrderedDish;
import main.db.entities.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static main.Controller.controller;


public class NewOrderCommand implements Command {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String[] dishIds = request.getParameterValues("dish_id");
        String[] dishAmounts = request.getParameterValues("dish_amount");
        List<OrderedDish> orderedDishes = new ArrayList<>();
        int price = 0;
        for (int i = 0; i < dishIds.length; i++) {
            if (dishAmounts[i].equals("0")) {
                continue;
            }
            int dishAmount = Integer.parseInt(dishAmounts[i]);
            Dish dish = DishesDAO.getInstance().findDish(Integer.parseInt(dishIds[i]));
            price += dish.getPrice() * dishAmount;
            OrderedDish orderedDish = new OrderedDish();
            orderedDish.setDishId(dish.getId());
            orderedDish.setDishAmount(dishAmount);
            orderedDishes.add(orderedDish);
        }
        HttpSession session = request.getSession();
        int userId = ((User) session.getAttribute("user")).getId();
        Order order = new Order();
        order.setUserId(userId);
        order.setPrice(price);
        session.setAttribute("orderedDishesA", orderedDishes);
        session.setAttribute("orderA", order);
        return controller + CommandNames.COMMAND__SHOW_ORDER_ADDRESSES;
    }
}
