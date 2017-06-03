package ubb.web.servlet;

import ubb.web.bean.domain.Role;
import ubb.web.bean.domain.User;
import ubb.web.repository.Repository;
import ubb.web.repository.UserMemoryRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

/**
 * @author Marius Adam
 */
public class MainServlet extends HttpServlet {
    private Repository<Long, User> userRepository;

    @Override
    public void init() throws ServletException {
        userRepository = UserMemoryRepository.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userRepository.findAll());
        req.setAttribute("roles", Arrays.asList(Role.values()));
        req.getRequestDispatcher("/WEB-INF/user/main.jsp").forward(req, resp);
    }
}
