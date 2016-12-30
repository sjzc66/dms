<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<head>
    <meta charset="utf-8" />
    <title>新增角色</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"/>
    <%@include file="../common/taglib.jsp"%>
    <!-- ================== END BASE CSS STYLE ================== -->

    <!-- ================== 单独作用于本页表格td ================== -->
    <style>
        #gadtable>tr>td {
            padding: 10px 15px;
            padding-top: 7px;
            padding-right: 15px;
            padding-bottom: 7px;
            padding-left: 15px;
        }
    </style>
    <!-- ================== 单独作用于本页表格td ================== -->

</head>
<body>
<!-- begin #page-loader -->
<div id="page-loader" class="fade in"><span class="spinner"></span></div>
<!-- end #page-loader -->

<!-- begin #page-container -->
<div id="page-container" class="fade page-sidebar-fixed page-header-fixed">
    <jsp:include page="../common/top.jsp"/>

    <!-- begin #sidebar -->
    <jsp:include page="../common/sitebar.jsp"/>
    <div class="sidebar-bg"></div>
    <!-- end #sidebar -->

    <!-- begin #content -->
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Tables</a></li>
            <li class="active">Managed Tables</li>
        </ol>
        <!-- end breadcrumb -->
        <!-- begin page-header -->
        <h1 class="page-header"> 在很久很久以前 <small>......</small></h1>
        <!-- end page-header -->

        <!-- begin row -->
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <c:choose>
                                <c:when test="${role.id!=null}">
                                    <h3 class="panel-title">编辑</h3>
                                </c:when>
                                <c:otherwise>
                                    <h3 class="panel-title">新增</h3>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="panel-body">

                            <form role="form" action="/sysrole/add" method="post" data-parsley-validate="true">
                                <input type="hidden" class="form-control" name="id" value="${role.id}">

                                <div class="form-group">
                                    <label for="name">角色名称</label>
                                    <input type="text" class="form-control input-lg" name="name" value="${role.name}" placeholder="请输入角色名称"  data-parsley-required="true" data-parsley-required-message="角色名称不能为空">
                                </div>

                                <div class="form-group">
                                    <label for="name">角色描述</label>
                                    <input type="text" class="form-control input-lg" name="description" value="${role.description}" placeholder="请输入角色描述"  data-parsley-required="true" data-parsley-required-message="角色描述不能为空">
                                </div>

                                <div class="form-group">
                                <label for="name">勾选资源</label>
                                    <table id="gadtable" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="100px">顶级菜单</th>
                                                <th>子菜单(<span style="color: blue;">按鈕</span>)</th>
                                            </tr>
                                        </thead>
                                        <c:forEach items="${list}" var="rootMenu">
                                            <tr>
                                                <td width="100px">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" onclick="oneOnclick(this)" name="idList" value="${rootMenu.rootMenuSysAuth.id}" />${rootMenu.rootMenuSysAuth.text}
                                                        </label>
                                                    </div>
                                                </td>


                                                <td>
                                                    <c:forEach items="${rootMenu.childMenus}" var="childMenu">

                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" onclick="secondOnclick(this)" name="idList" value="${rootMenu.rootMenuSysAuth.id}" />${childMenu.childMenuSysAuth.text}
                                                                (
                                                                <c:forEach items="${childMenu.childButtons}" var="childButton">
                                                                    <%----->--%>
                                                                    <%--<div class="checkbox">--%>
                                                                        <label>
                                                                            <input type="checkbox" onclick="thirdOnclick(this)" name="idList" value="${childButton.id}" /><span style="color: blue;">${childButton.text}</span>
                                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%--</div>--%>
                                                                </c:forEach>
                                                                )
                                                            </label>
                                                        </div>

                                                    </c:forEach>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>

                                <button type="submit" class="btn btn-primary m-r-5 m-b-5">提交</button>
                            </form>

                        </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-12 -->
        </div>
        <!-- end row -->
    </div>
    <!-- end #content -->

    <!-- begin scroll to top btn -->
    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top"><i class="fa fa-angle-up"></i></a>
    <!-- end scroll to top btn -->
</div>
<!-- end page container -->
<jsp:include page="../common/footer.jsp"/>


<!-- ================== END PAGE LEVEL JS ================== -->

<script>
    if(${role.id!=null}){
        document.title='编辑角色';
    }

    $(document).ready(function() {
        App.init();
        Dashboard.init();

        $("table tr:gt(0)").each(function(i){
            $(this).find('input[type=checkbox]').eq(0).attr("checked",true);
        });
    });

    function oneOnclick(obj) {
        obj = $(obj);
        if(obj.attr("checked")){
            obj.parents('td:first').next().find('input[type=checkbox]').attr("checked",true);
        }else{
            obj.parents('td:first').next().find('input[type=checkbox]').attr("checked",false);
        }
    }

    function secondOnclick(obj) {
        obj = $(obj);
        if(obj.attr("checked")){
            obj.parents('label:first').find('input[type=checkbox]').attr("checked",true);
            obj.parents('td:first').prev().find('input[type=checkbox]').attr("checked",true);
        }else{
            obj.parents('td:first').find('input[type=checkbox]').attr("checked",false);
        }
    }

    function thirdOnclick(obj) {
        obj = $(obj);
        if(obj.attr("checked")){
            obj.parents('div:first').find('input[type=checkbox]').eq(0).attr("checked",true);
            obj.parents('td:first').prev().find('input[type=checkbox]').attr("checked",true);
        }
    }


</script>

</body>
</html>
