//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.sjzc.dms.interceptor;

import com.jzfq.fms.common.common.Pageable;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.MappedStatement.Builder;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.lang.reflect.Constructor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;


@Intercepts({@Signature(
        type = Executor.class,
        method = "query",
        args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}
)})
public class PageInterceptor implements Interceptor {
    private static final Log logger = LogFactory.getLog(PageInterceptor.class);
    private static Dialect DIALECT_CLASS = null;
    private static int MAPPED_STATEMENT_INDEX = 0;
    private static int PARAMETER_INDEX = 1;
    private static int ROWBOUNDS_INDEX = 2;

    public PageInterceptor() {
    }

    public Object intercept(Invocation invocation) throws Throwable {
        Object[] queryArgs = invocation.getArgs();
        RowBounds rowBounds = (RowBounds) queryArgs[ROWBOUNDS_INDEX];
        if (!(rowBounds instanceof Pageable)) {
            return invocation.proceed();
        } else {
            MappedStatement mappedStatement = (MappedStatement) queryArgs[MAPPED_STATEMENT_INDEX];
            Object parameterObject = queryArgs[PARAMETER_INDEX];
            BoundSql boundSql = mappedStatement.getBoundSql(parameterObject);
            HashMap pageParameters = new HashMap();
            if (parameterObject instanceof Map) {
                pageParameters.putAll((Map) parameterObject);
            } else {
                Iterator page = boundSql.getParameterMappings().iterator();
                while (page.hasNext()) {
                    ParameterMapping parameterMappings = (ParameterMapping) page.next();
                    pageParameters.put(parameterMappings.getProperty(), parameterObject);
                }
            }

            ArrayList parameterMappings1 = new ArrayList(boundSql.getParameterMappings());
            Pageable page1 = (Pageable) rowBounds;
            if (page1.isOnlySort()) {
                StringBuilder sql1 = new StringBuilder(boundSql.getSql());
                sql1.append(" order by ").append(page1.getSort());
                queryArgs[MAPPED_STATEMENT_INDEX] = this.copyFromNewSql(mappedStatement, boundSql, sql1.toString(), parameterMappings1, pageParameters);
                return invocation.proceed();
            } else {
                String sql = boundSql.getSql();
                if (StringUtils.isNotBlank(page1.getSort())) {
                    StringBuilder pageSql = new StringBuilder(sql);
                    pageSql.append(" order by ").append(page1.getSort());
                    sql = pageSql.toString();
                }

                String pageSql1 = DIALECT_CLASS.buildPageSqlAndSetParameters(mappedStatement, sql, page1, pageParameters, parameterMappings1);
                queryArgs[MAPPED_STATEMENT_INDEX] = this.copyFromNewSql(mappedStatement, boundSql, pageSql1, parameterMappings1, pageParameters);
                queryArgs[PARAMETER_INDEX] = pageParameters;
                queryArgs[ROWBOUNDS_INDEX] = new RowBounds(0, 2147483647);
                int totalCount = getCount(mappedStatement, parameterObject, boundSql);
                PageList pageList = new PageList(page1.getCurrentPage(), page1.getPageSize());
                pageList.setTotalCount(totalCount);
                int totalPage = totalCount / pageList.getPageSize() + (totalCount % pageList.getPageSize() == 0 ? 0 : 1);
                pageList.setTotalPage(totalPage);
                Object result = invocation.proceed();
                pageList.addAll((List) result);
                return pageList;
            }
        }
    }

    public static int getCount(MappedStatement mappedStatement, Object parameterObject, BoundSql boundSql) throws SQLException {
        String countSql = "select count(0) from (" + boundSql.getSql() + ") as total";
        if (logger.isDebugEnabled()) {
            logger.debug("Total count SQL [{}] " + countSql);
            logger.debug("Total count Parameters: {} " + parameterObject);
        }

        Connection connection = null;
        PreparedStatement countStmt = null;
        ResultSet rs = null;

        int var10;
        try {
            connection = mappedStatement.getConfiguration().getEnvironment().getDataSource().getConnection();
            countStmt = connection.prepareStatement(countSql);
            DefaultParameterHandler handler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
            handler.setParameters(countStmt);
            rs = countStmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }

            if (logger.isDebugEnabled()) {
                logger.debug("Total count: {}" + count);
            }

            var10 = count;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } finally {
                try {
                    if (countStmt != null) {
                        countStmt.close();
                    }
                } finally {
                    if (connection != null && !connection.isClosed()) {
                        connection.close();
                    }

                }

            }

        }

        return var10;
    }

    private MappedStatement copyFromNewSql(MappedStatement ms, BoundSql boundSql, String sql, List<ParameterMapping> parameterMappings, Object parameter) {
        BoundSql newBoundSql = this.copyFromBoundSql(ms, boundSql, sql, parameterMappings, parameter);
        return this.copyFromMappedStatement(ms, new PageInterceptor.BoundSqlSqlSource(newBoundSql));
    }

    private BoundSql copyFromBoundSql(MappedStatement ms, BoundSql boundSql, String sql, List<ParameterMapping> parameterMappings, Object parameter) {
        BoundSql newBoundSql = new BoundSql(ms.getConfiguration(), sql, parameterMappings, parameter);
        Iterator var8 = boundSql.getParameterMappings().iterator();

        while (var8.hasNext()) {
            ParameterMapping mapping = (ParameterMapping) var8.next();
            String prop = mapping.getProperty();
            if (boundSql.hasAdditionalParameter(prop)) {
                newBoundSql.setAdditionalParameter(prop, boundSql.getAdditionalParameter(prop));
            }
        }

        return newBoundSql;
    }

    private MappedStatement copyFromMappedStatement(MappedStatement ms, SqlSource newSqlSource) {
        Builder builder = new Builder(ms.getConfiguration(), ms.getId(), newSqlSource, ms.getSqlCommandType());
        builder.resource(ms.getResource());
        builder.fetchSize(ms.getFetchSize());
        builder.statementType(ms.getStatementType());
        builder.keyGenerator(ms.getKeyGenerator());
        if (ms.getKeyProperties() != null && ms.getKeyProperties().length != 0) {
            StringBuffer keyProperties = new StringBuffer();
            String[] var8;
            int var7 = (var8 = ms.getKeyProperties()).length;

            for (int var6 = 0; var6 < var7; ++var6) {
                String keyProperty = var8[var6];
                keyProperties.append(keyProperty).append(",");
            }

            keyProperties.delete(keyProperties.length() - 1, keyProperties.length());
            builder.keyProperty(keyProperties.toString());
        }

        builder.timeout(ms.getTimeout());
        builder.parameterMap(ms.getParameterMap());
        builder.resultMaps(ms.getResultMaps());
        builder.resultSetType(ms.getResultSetType());
        builder.cache(ms.getCache());
        builder.flushCacheRequired(ms.isFlushCacheRequired());
        builder.useCache(ms.isUseCache());
        return builder.build();
    }

    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    public void setProperties(Properties properties) {
        logger.debug("mybatis setProperties");
        if (DIALECT_CLASS == null) {
            synchronized (properties) {
                if (DIALECT_CLASS == null) {
                    String dialectClassStr = properties.getProperty("dialectClass");
                    Class dialectClass = null;

                    try {
                        dialectClass = Class.forName(dialectClassStr);
                        Constructor e = dialectClass.getConstructor(new Class[0]);
                        DIALECT_CLASS = (Dialect) e.newInstance(new Object[0]);
                    } catch (Exception var6) {
                        throw new RuntimeException(new ClassNotFoundException("Cannot create dialect instance: " + dialectClass, var6));
                    }

                    logger.debug("mybatis load dialectClass");
                }
            }
        }

    }

    public static class BoundSqlSqlSource implements SqlSource {
        BoundSql boundSql;

        public BoundSqlSqlSource(BoundSql boundSql) {
            this.boundSql = boundSql;
        }

        public BoundSql getBoundSql(Object parameterObject) {
            return this.boundSql;
        }
    }
}
