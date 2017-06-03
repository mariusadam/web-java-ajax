package ubb.web.repository;

import ubb.web.bean.domain.Entity;
import ubb.web.bean.utils.Pagination;

import java.util.Collection;

/**
 * @author Marius Adam
 */
public interface Repository<IdType, EntityType extends Entity<IdType>> {
    Collection<EntityType> findAll();

    Collection<EntityType> findAll(Pagination pagination);

    Collection<EntityType> findBy(String property, Object value) throws Exception;

    EntityType findOneBy(String property, Object value) throws Exception;

    EntityType findById(IdType id) throws Exception;

    IdType save(EntityType object);

    EntityType delete(IdType id) throws Exception;

    EntityType delete(EntityType object) throws Exception;

    Long size();
}
