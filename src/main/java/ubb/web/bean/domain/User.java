package ubb.web.bean.domain;

/**
 * @author Marius Adam
 */
public class User extends Entity<Long> {
    private           String  name;
    private           String  username;
    private transient String  password;
    private           Integer age;
    private           String  email;
    private           String  webPage;
    private           Role    role;

    public User() {
    }

    public User(String name, String username, String password, Integer age, String email, String webPage, Role role) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.age = age;
        this.email = email;
        this.webPage = webPage;
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebPage() {
        return webPage;
    }

    public void setWebPage(String webPage) {
        this.webPage = webPage;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
