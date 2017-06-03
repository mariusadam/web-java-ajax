package ubb.web.repository;

import ubb.web.bean.domain.Entity;
import ubb.web.bean.utils.Pagination;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

/**
 * @author Marius Adam
 */
public abstract class MemoryRepository<IdType, EntityType extends Entity<IdType>> implements Repository<IdType, EntityType> {
    private List<EntityType>  items;
    private Class<EntityType> entityTypeClass;

    public MemoryRepository(Class<EntityType> entityTypeClass) {
        this.entityTypeClass = entityTypeClass;
        this.items = new ArrayList<>();
        beforeLoadMockData();
        loadMockData();
    }

    protected void beforeLoadMockData() {

    }

    protected void loadMockData() {
    }


    @Override
    public Collection<EntityType> findAll() {
        return items;
    }

    @Override
    public Collection<EntityType> findBy(String property, Object value) throws Exception {
        Method propertyGetter = new PropertyDescriptor(property, entityTypeClass).getReadMethod();

        return findAll().stream().filter(entity -> {
            try {
                return propertyGetter.invoke(entity).equals(value);
            } catch (IllegalAccessException | InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
    }

    @Override
    public EntityType findOneBy(String property, Object value) throws Exception {
        Collection<EntityType> result = findBy(property, value);
        if (result.isEmpty()) {
            throw new NoSuchElementException(String.format(
                    "Could not find the %s with %s equal to %s",
                    entityTypeClass.getSimpleName(),
                    property,
                    value
            ));
        }

        return result.iterator().next();
    }

    @Override
    public EntityType findById(IdType id) throws Exception {
        EntityType obj = findOneBy("id", id);
        if (obj == null) {
            throw new NoSuchElementException(String.format(
                    "Could not find the %s with id %s",
                    entityTypeClass.getSimpleName(),
                    id
            ));
        }

        return obj;
    }

    @Override
    public IdType save(EntityType object) {
        if (object.getId() == null) {
            object.setId(nextId());
        }
        items.add(object);

        return object.getId();
    }

    @Override
    public EntityType delete(IdType id) throws Exception {
        EntityType deletedObj = findById(id);
        boolean deleted = items.remove(deletedObj);
        if (!deleted) {
            throw new Exception(String.format(
                    "%s with id %s could not be deleted.",
                    entityTypeClass.getSimpleName(),
                    id
            ));
        }
        return deletedObj;
    }

    @Override
    public Collection<EntityType> findAll(Pagination pagination) {
        Integer offset = pagination.offset();
        Collection<EntityType> result = new ArrayList<>();
        for (int i = offset; result.size() < pagination.getSize() && i < items.size(); i++) {
            result.add(items.get(i));
        }

        return result;
    }

    @Override
    public EntityType delete(EntityType object) throws Exception {
        return delete(object.getId());
    }

    @Override
    public Long size() {
        return (long) items.size();
    }

    protected abstract IdType nextId();
}
