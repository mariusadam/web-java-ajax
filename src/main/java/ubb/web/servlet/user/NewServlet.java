package ubb.web.servlet.user;

import ubb.web.bean.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Marius Adam
 */
public class NewServlet extends HttpServlet {
    public final static String UserBeanId = "user";
    public final static String NewUserJsp = "/WEB-INF/user/new.jsp";
    public final static String ListUserJsp = "/WEB-INF/user/list.jsp";
    public final static String CrsfTokenId = "_user_crsf_token";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setName("ssssssssssdasdasdas");
        req.setAttribute(UserBeanId, user);

        req.getRequestDispatcher(NewUserJsp).forward(req, resp);
    }
}
