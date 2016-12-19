package com.sjzc.common;

import org.apache.ibatis.session.RowBounds;

import java.io.Serializable;


public class Pageable extends RowBounds implements Serializable {
    private static final long serialVersionUID = -4950093713814239695L;
    public static final int DEFAULT_PAGE_SIZE = 5;
    private int pageSize;
    private int currentPage;
    private boolean onlySort;
    private String sort;

    public Pageable() {
        this.currentPage = 1;
        this.pageSize = DEFAULT_PAGE_SIZE;
        this.onlySort = false;
    }

    public Pageable(int currentPage) {
        this.currentPage = currentPage;
        this.pageSize = DEFAULT_PAGE_SIZE;
        this.onlySort = false;
    }

    public Pageable(int currentPage, int pageSize) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.onlySort = false;
    }

    public Pageable(int currentPage, int pageSize, String sort) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.sort = sort;
        this.onlySort = false;
    }

    public Pageable(String sort) {
        this.sort = sort;
        this.onlySort = true;
    }

    public int getCurrentPage() {
        return this.currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public boolean isOnlySort() {
        return this.onlySort;
    }

    public void setOnlySort(boolean onlySort) {
        this.onlySort = onlySort;
    }

    public String getSort() {
        return this.sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    
}
