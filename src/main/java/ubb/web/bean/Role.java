package ubb.web.bean;

/**
 * @author Marius Adam
 */
public enum Role {
    Admin("Admin", 1000),
    RegularUser("Regular user", 1);

    private String name;
    private Integer accessLevel;

    Role(String name, Integer accessLevel) {
        this.name = name;
        this.accessLevel = accessLevel;
    }

    public boolean canOverride(Role other) {
        return this.accessLevel > other.accessLevel;
    }

    @Override
    public String toString() {
        return name;
    }
}
