package ubb.web.bean.utils;

/**
 * @author Marius Adam
 */
public class Pagination {
    private Integer page;
    private Integer size;

    public Pagination(Integer page, Integer size) {
        this.page = Math.max(1, page);
        this.size = Math.max(0, size);
    }

    public Integer getPage() {
        return page;
    }

    public Integer getSize() {
        return size;
    }

    public Integer offset() {
        return (page - 1) * size;
    }

    public boolean hasNext(Long totalSize) {
        return totalSize > offset() + getSize();
    }

    public Pagination next() {
        return new Pagination(page + 1, size);
    }

    @Override
    public String toString() {
        return String.format(
                "page = %d, size = %d",
                page,
                size
        );
    }
}
