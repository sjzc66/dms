package com.sjzc.dms.interceptor;

import java.util.ArrayList;
import java.util.List;

public class PageList<E> extends ArrayList<E> implements List<E> {
    private static final long serialVersionUID = -6459116737938993743L;
    private int pageSize;
    private int currentPage;
    private int totalPage;
    private int totalCount;

    public PageList(int currentPage, int pageSize) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
    }

    private void repaginate() {
        if (this.pageSize < 1) {
            this.pageSize = 10;
        }

        if (this.currentPage < 1) {
            this.currentPage = 1;
        }

        if (this.currentPage > this.totalPage) {
            this.currentPage = this.totalPage;
        }

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

    public int getTotalPage() {
        return this.totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
        this.repaginate();
    }

    public int getTotalCount() {
        return this.totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
}

