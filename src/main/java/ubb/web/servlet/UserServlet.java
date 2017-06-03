package ubb.web.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import ubb.web.bean.domain.User;
import ubb.web.bean.utils.Pagination;
import ubb.web.repository.Repository;
import ubb.web.repository.UserMemoryRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

/**
 * @author Marius Adam
 */
public class UserServlet extends HttpServlet {
    public final static String UserBeanId       = "user";
    public final static String NewUserJsp       = "/WEB-INF/user/new.jsp";
    public final static String ListUserJsp      = "/WEB-INF/user/list.jsp";
    public final static String CrsfTokenId      = "_user_crsf_token";
    public final static String lastEditedUserId = "_session_last_edited_user";

    private Repository<Long, User> userRepository;
    private Gson                   gson;

    @Override
    public void init() throws ServletException {
        userRepository = UserMemoryRepository.getInstance();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("utf-8");
        JsonObject jsonResponse = new JsonObject();
        try {
            String paramTemplate = "load_users_form[%s]";
            Integer page = Integer.parseInt(req.getParameter(String.format(paramTemplate, "page")));
            Integer size = Integer.parseInt(req.getParameter(String.format(paramTemplate, "size")));
            Pagination pagination = new Pagination(page, size);
            System.out.println(pagination);

            Collection<?> items = userRepository.findAll(pagination);
            jsonResponse.addProperty("status", "success");
            jsonResponse.add("items", gson.toJsonTree(items));
            System.out.println(userRepository.size() + " " + pagination.offset());
            jsonResponse.add("next", gson.toJsonTree(pagination.next()));
        } catch (Exception e) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getMessage());
        }
        resp.getWriter().write(jsonResponse.toString());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("utf-8");
        JsonObject jsonResponse = new JsonObject();
        try {
            String pathInfo = req.getPathInfo();
            String[] parts = pathInfo.split("/");
            Long userId = Long.parseLong(parts[parts.length - 1]);
            userRepository.delete(userId);
            jsonResponse.addProperty("message", String.format("User with id %d was deleted.", userId));
            jsonResponse.addProperty("status", "success");
        } catch (Exception e) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getMessage());
        }
        resp.getWriter().write(jsonResponse.toString());
    }
}
