//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//
package com.sjzc.dms.interceptor;
import com.sjzc.dms.common.common.Pageable;

import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;

import org.apache.ibatis.mapping.ParameterMapping.Builder;

import java.util.List;
import java.util.Map;

public class MysqlDialect implements Dialect {
    public MysqlDialect() {
    }

    public String buildPageSqlAndSetParameters(MappedStatement mappedStatement, String sql, Pageable page, Map<String, Object> pageParameters, List<ParameterMapping> parameterMappings) {
        StringBuilder pageSql = new StringBuilder(100);
        Integer beginrow = Integer.valueOf((page.getCurrentPage() - 1) * page.getPageSize());
        pageSql.append(sql);
        pageSql.append(" limit ?,?");
        pageParameters.put("__offset", beginrow);
        ParameterMapping parameterMapping = (new Builder(mappedStatement.getConfiguration(), "__offset", Integer.class)).build();
        parameterMappings.add(parameterMapping);
        pageParameters.put("__limit", Integer.valueOf(page.getPageSize()));
        parameterMapping = (new Builder(mappedStatement.getConfiguration(), "__limit", Integer.class)).build();
        parameterMappings.add(parameterMapping);
        return pageSql.toString();
    }
}
