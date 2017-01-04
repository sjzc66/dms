package com.sjzc.dms.controller;

import com.sjzc.dms.common.JsonResult;
import com.sjzc.common.DataTable;
import com.sjzc.common.PageVo;
import com.sjzc.common.Pageable;
import com.sjzc.dms.interceptor.PageList;
import com.sjzc.exception.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * 基础封装
 */
public class BaseController {

    private static final Logger log = LoggerFactory.getLogger("BaseController");


    /**
     * 表格数据加载请求：封裝表格(dataTable)的ajax请求參數
     */
    protected static PageVo parametToPageVo(HttpServletRequest request, Class sc) {
        PageVo vo = new PageVo();

        //获取私有屬性
        Field[] fieldArray = sc.getDeclaredFields();

        // 封装查询参数
        Map<String, Object> parameters = new HashMap<>(10);
        for (Field field : fieldArray) {
            String filedName = field.getName();
            String searchParameter = request.getParameter(filedName);
            if (!StringUtils.isEmpty(searchParameter)) {
                log.info("查询参数=>filedName：" + filedName + "--->" + "searchParameter:" + searchParameter);
                parameters.put(filedName, searchParameter);
            }
        }
        vo.setParameters(parameters);

        // 封装分页参数
        Pageable pageable = new Pageable();
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        //封装排序参数
        String order = request.getParameter("order[0][column]");//排序的列号  
        String orderDir = request.getParameter("order[0][dir]");//排序的顺序asc or desc  
        String orderColumn = request.getParameter("columns[" + order + "][data]");//排序的列
        log.info("标题排序参数：排序的列号：" + order + "；排序的顺序：" + orderDir + ";排序的列：" + orderColumn);
        Map<String, Object> sortParameters = new HashMap<String, Object>();
        sortParameters.put("orderColumn", orderColumn);
        sortParameters.put("orderDir", orderDir);
        vo.setSort(sortParameters);

        pageable.setCurrentPage((Integer.parseInt(start) / Integer.parseInt(length) + 1));
        log.info("分页参数=>第X页：" + (Integer.parseInt(start) / Integer.parseInt(length) + 1));
        vo.setPageable(pageable);

        return vo;
    }


    /**
     * 处理请求返回结果：封装拉取的数据给表格(dataTable)以便渲染出内容
     */
    protected static DataTable resultToDataTable(PageList list) {
        DataTable dt = new DataTable();
        long displayCount = list.size();
        long TotalCount = list.getTotalCount();
        dt.setAaData(list);
        dt.setiTotalDisplayRecords(TotalCount);
        dt.setiTotalRecords(TotalCount);
        return dt;
    }


    /**
     * 处理时间的转换器，默认格式是yyyy-MM-dd HH:mm:ss可以被重载
     *
     * @param binder
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    @ExceptionHandler
    @ResponseBody
    public final JsonResult handleException(HttpServletRequest request, Exception ex) {

        if (ex instanceof ServiceException) {
            ServiceException be = (ServiceException) ex;
            ex.printStackTrace();
            return JsonResult.createErrorMsg(be.getMessage());
        }
        ex.printStackTrace();
        return JsonResult.createErrorMsg("系统异常");
    }

    public static JsonResult returnSuccess(String msg) {
        return JsonResult.createSuccess(msg);
    }

    public static JsonResult returnSuccess(Object obj, String msg) {
        return JsonResult.createSuccess(obj, msg);
    }

    public static JsonResult returnSuccess() {
        return JsonResult.createSuccess();
    }

    public static JsonResult returnSuccess(Object obj) {
        return JsonResult.createSuccess(obj);
    }

    public JsonResult returnFaild(String msg) {
        return JsonResult.createErrorMsg(msg);

    }


    /**
     * 表格数据加载请求：封裝表格(StrapTable)的ajax请求參數
     */
    protected static PageVo parametToPageVoForStrapTable(HttpServletRequest request) {
        PageVo vo = new PageVo();
        Map<String, Object> parameters = new HashMap(10);
        Enumeration enums = request.getParameterNames();
        while (enums.hasMoreElements()) {
            String filedName = (String) enums.nextElement();
            String searchParameter = request.getParameter(filedName);
            if (!StringUtils.isEmpty(searchParameter)) {
                log.info("查询参数=>filedName：" + filedName + "--->" + "searchParameter:" + searchParameter);
                parameters.put(filedName, searchParameter);
            }
        }
        vo.setParameters(parameters);
        // 封装分页参数
        Pageable pageable = new Pageable();
        String currentPage = request.getParameter("currentPage");
        String pageSize = request.getParameter("pageSize");
        pageable.setCurrentPage(Integer.valueOf(currentPage));
        pageable.setPageSize(Integer.valueOf(pageSize));
        vo.setPageable(pageable);
        return vo;
    }

    /**
     * 处理请求返回结果：封装拉取的数据给表格(strapTable)以便渲染出内容
     */
    /*protected static StrapTable resultToStrapTable(PageList list) {
        StrapTable dt = new StrapTable();
        int TotalCount = list.getTotalCount();
        dt.setRows(list);
        dt.setTotal(TotalCount);
        return dt;
    }*/
}
