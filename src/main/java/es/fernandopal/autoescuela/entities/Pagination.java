package es.fernandopal.autoescuela.entities;

public class Pagination {
    private Integer page;
    private Integer maxResults;

    public Pagination() {
        this.page = 0;
        this.maxResults = 20;
    }

    public Pagination(Integer page, Integer maxResults) {
        this.page = page;
        this.maxResults = maxResults;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getMaxResults() {
        return maxResults;
    }

    public void setMaxResults(Integer maxResults) {
        this.maxResults = maxResults;
    }
}
