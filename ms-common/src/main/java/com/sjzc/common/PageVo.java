
package com.sjzc.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 分页以及查询参数封装的model
 *
 * @author
 */
public class PageVo {

    // 分页参数
    private Pageable pageable;

    // 查询参数
    private Map<String, Object> parameters = new HashMap<>(10);

    // 排序参数
    private Map<String, Object> sort;

    public Pageable getPageable() {
        return this.pageable;
    }

    public void setPageable(Pageable pageable) {
        this.pageable = pageable;
    }

    public Map<String, Object> getParameters() {
        return this.parameters;
    }

    public void setParameters(Map<String, Object> parameters) {
        this.parameters = parameters;
    }

    public Map<String, Object> getSort() {
        return this.sort;
    }

    public void setSort(Map<String, Object> sort) {
        this.sort = sort;
    }

}
