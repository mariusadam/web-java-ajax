package ubb.web.repository;

import ubb.web.bean.domain.Entity;

/**
 * @author Marius Adam
 */
public class MemoryRepositoryLongId<EntityType extends Entity<Long>> extends MemoryRepository<Long, EntityType> {
    private Long lastId;

    public MemoryRepositoryLongId(Class<EntityType> entityTypeClass) {
        super(entityTypeClass);
    }

    @Override
    protected void beforeLoadMockData() {
        lastId = 0L;
    }

    @Override
    protected Long nextId() {
        return ++lastId;
    }
}
