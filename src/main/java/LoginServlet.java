import db.DBManager;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        DBManager dbManager = DBManager.getInstance();

        if (dbManager.check(username, password)) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.removeAttribute("failedToLogin");
            session.setMaxInactiveInterval(60*60*24); // 1 day
            resp.sendRedirect("startPage.jsp");
        }
        else {
            HttpSession session = req.getSession();
            session.setAttribute("failedToLogin", true);
            resp.sendRedirect("login.jsp");
        }
    }
}
