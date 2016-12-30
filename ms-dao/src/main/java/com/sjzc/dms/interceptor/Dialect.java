
package com.sjzc.dms.interceptor;

import com.sjzc.dms.common.common.Pageable;

import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;

import java.util.List;
import java.util.Map;

public interface Dialect {
    String OFFSET_NAME = "__offset";
    String LIMIT_NAME = "__limit";

    String buildPageSqlAndSetParameters(MappedStatement var1, String var2, Pageable var3, Map<String, Object> var4, List<ParameterMapping> var5);
}
