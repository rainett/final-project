package main.db.dao;

import main.db.DBManager;
import main.db.EntityMapper;
import main.db.Fields;
import main.db.entities.Dish;
import main.db.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DishesDAO {
    private static final String SQL__GET_ALL_DISHES =
            "SELECT * FROM dishes";

    private static final String SQL__FIND_DISH_BY_ID =
            "SELECT * FROM dishes WHERE dish_id = binary ?";

    private static final String SQL__FIND_DISH_BY_NAME =
            "SELECT * FROM dishes WHERE dish_name = binary ?";

    private static final String SQL_UPDATE_DISH =
            "UPDATE dishes SET dish_name=?, dish_price=?, dish_pic=? WHERE dish_id=?";

    private static final String SQL_INSERT_DISH =
            "INSERT INTO dishes (dish_name, dish_price, dish_pic) VALUES ( ?, ?, ? )";

    public List<Dish> getAllDishes(String sorting) {
        String query = sorting == null ? SQL__GET_ALL_DISHES : DishesSorting.getSortQuery(sorting);
        List<Dish> dishes = new ArrayList<>();
        PreparedStatement pstmt;
        ResultSet rs;
        Connection con = null;
        try {
            con = DBManager.getInstance().getConnection();
            DishMapper mapper = new DishMapper();
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                dishes.add(mapper.mapRow(rs));
            }
            rs.close();
            pstmt.close();
        } catch (SQLException ex) {
            assert con != null;
            DBManager.getInstance().rollbackAndClose(con);
            ex.printStackTrace();
        } finally {
            assert con != null;
            DBManager.getInstance().commitAndClose(con);
        }
        return dishes;
    }

    public Dish findDish(int id) {
        Dish dish = null;
        PreparedStatement pstmt;
        ResultSet rs;
        Connection con = null;
        try {
            con = DBManager.getInstance().getConnection();
            DishMapper mapper = new DishMapper();
            pstmt = con.prepareStatement(SQL__FIND_DISH_BY_ID);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next())
                dish = mapper.mapRow(rs);
            rs.close();
            pstmt.close();
        } catch (SQLException ex) {
            assert con != null;
            DBManager.getInstance().rollbackAndClose(con);
            ex.printStackTrace();
        } finally {
            assert con != null;
            DBManager.getInstance().commitAndClose(con);
        }
        return dish;
    }

    public Dish findDish(String name) {
        Dish dish = null;
        PreparedStatement pstmt;
        ResultSet rs;
        Connection con = null;
        try {
            con = DBManager.getInstance().getConnection();
            DishMapper mapper = new DishMapper();
            pstmt = con.prepareStatement(SQL__FIND_DISH_BY_NAME);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if (rs.next())
                dish = mapper.mapRow(rs);
            rs.close();
            pstmt.close();
        } catch (SQLException ex) {
            assert con != null;
            DBManager.getInstance().rollbackAndClose(con);
            ex.printStackTrace();
        } finally {
            assert con != null;
            DBManager.getInstance().commitAndClose(con);
        }
        return dish;
    }

    public void updateDish(Dish dish) {
        Connection con = null;
        try {
            con = DBManager.getInstance().getConnection();
            updateDish(con, dish);
        } catch (SQLException ex) {
            assert con != null;
            DBManager.getInstance().rollbackAndClose(con);
            ex.printStackTrace();
        } finally {
            assert con != null;
            DBManager.getInstance().commitAndClose(con);
        }
    }

    private void updateDish(Connection con, Dish dish) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement(SQL_UPDATE_DISH);
        int k = 1;
        pstmt.setString(k++, dish.getName());
        pstmt.setLong(k++, dish.getPrice());
        pstmt.setString(k++, dish.getPic());
        pstmt.setLong(k, dish.getId());
        pstmt.executeUpdate();
        pstmt.close();
    }

    public void addDish(String name, int price, String pic) {
        Connection con = null;
        try {
            con = DBManager.getInstance().getConnection();
            insertDish(name, price, pic, con);
        } catch (SQLException ex) {
            assert con != null;
            DBManager.getInstance().rollbackAndClose(con);
            ex.printStackTrace();
        } finally {
            assert con != null;
            DBManager.getInstance().commitAndClose(con);
        }
    }

    private void insertDish(String name, int price, String pic, Connection con) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement(SQL_INSERT_DISH);
        int k = 1;
        pstmt.setString(k++, name);
        pstmt.setLong(k++, price);
        pstmt.setString(k, pic);
        pstmt.executeUpdate();
        pstmt.close();
    }


    private static class DishMapper implements EntityMapper<Dish> {
        @Override
        public Dish mapRow(ResultSet rs) {
            Dish dish = new Dish();
            try {
                dish.setId(rs.getInt(Fields.FIELD__DISH_ID));
                dish.setName(rs.getString(Fields.FIELD__DISH_NAME));
                dish.setPrice(rs.getInt(Fields.FIELD__DISH_PRICE));
                dish.setPic(rs.getString(Fields.FIELD__DISH_PIC));
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return dish;
        }
    }

}
