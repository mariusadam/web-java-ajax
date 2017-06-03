package ubb.web.repository;

import io.codearte.jfairy.Fairy;
import io.codearte.jfairy.producer.person.Person;
import ubb.web.bean.domain.Role;
import ubb.web.bean.domain.User;

/**
 * @author Marius Adam
 */
public class UserMemoryRepository extends MemoryRepositoryLongId<User> {
    private static UserMemoryRepository instance;

    protected UserMemoryRepository() {
        super(User.class);
    }

    public static Repository<Long, User> getInstance() {
        if (instance == null) {
            instance = new UserMemoryRepository();
            System.out.println("Creating user repository singleton");
        }

        return instance;
    }

    @Override
    protected void loadMockData() {
        Integer usersToAdd = 1000;
        Fairy fairy = Fairy.create();
        for (int i = 1; i <= usersToAdd; i++) {
            Person person = fairy.person();
            save(new User(
                    person.getFullName(),
                    person.getUsername(),
                    person.getPassword(),
                    person.getAge(),
                    person.getEmail(),
                    "http://" + person.getTelephoneNumber() + ".me",
                    Role.RegularUser
            ));
        }

        save(new User(
                "Administrator",
                "admin",
                "admin",
                40,
                "admin@gmail.com",
                "http://admin.page.me",
                Role.Admin
        ));
    }
}
