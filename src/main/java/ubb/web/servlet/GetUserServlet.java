package ubb.web.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import ubb.web.bean.domain.User;
import ubb.web.repository.Repository;
import ubb.web.repository.UserMemoryRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Marius Adam
 */
public class GetUserServlet extends HttpServlet {
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
            String pathInfo = req.getPathInfo();
            String[] parts = pathInfo.split("/");
            Long userId = Long.parseLong(parts[parts.length - 1]);

            jsonResponse.add("user", gson.toJsonTree(userRepository.findById(userId)));
            jsonResponse.addProperty("status", "success");
        } catch (Exception e) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getMessage());
        }
        resp.getWriter().write(jsonResponse.toString());
    }
}
