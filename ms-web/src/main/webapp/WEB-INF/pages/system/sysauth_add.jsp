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
    <title>新增资源</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"/>
    <%@include file="../common/taglib.jsp"%>
    <!-- ================== END BASE CSS STYLE ================== -->

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

        <c:choose>
            <c:when test="${type=='menu'}">
                <!-- begin row -->
                <div class="row">
                    <!-- begin col-12 -->
                    <div class="col-md-12">
                        <!-- begin panel -->
                        <div class="panel panel-inverse">
                            <div class="panel-heading">
                                <c:choose>
                                    <c:when test="${auth.id!=null}">
                                        <h3 class="panel-title">编辑菜单</h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h3 class="panel-title">新增菜单</h3>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="panel-body">

                                <form role="form" action="/sysauth/add" method="post" data-parsley-validate="true">
                                    <input type="hidden" class="form-control" name="id" value="${auth.id}">

                                    <c:choose>
                                        <c:when test="${auth.id!=null}">
                                            <div class="form-group"><label for="name">资源类型</label><input type="text" class="form-control input-lg" value="${auth.iconCls}" disabled="ture"></div>
                                            <div class="form-group"><label for="name">父级菜单</label><input type="text" class="form-control input-lg" value="${parentName}" disabled="ture"></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="form-group">
                                                <label for="name">资源类型</label>
                                                <input type="text" class="form-control input-lg" name="iconCls" value="menu" disabled="ture">
                                                <input type="hidden" name="iconCls" value="menu">
                                            </div>
                                            <div class="form-group">
                                                <label for="name">父级菜单</label>
                                                <select class="form-control input-lg" name="parentId" placeholder="请输入父级资源"  data-parsley-required="true" data-parsley-required-message="父级资源不能为空">
                                                    <c:forEach items="${list}" var="auth">
                                                        <option value="${auth.id}">${auth.text}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="form-group">
                                        <label for="name">菜单名称</label>
                                        <input type="text" class="form-control input-lg" name="text" value="${auth.text}" placeholder="规范格式：系统管理-用户管理"  data-parsley-required="true" data-parsley-required-message="菜单名称不能为空">
                                    </div>

                                    <div class="form-group">
                                        <label for="name">URL</label>
                                        <input type="text" class="form-control input-lg" name="url" value="${auth.url}" placeholder="请输入菜单URL"  data-parsley-required="true" data-parsley-required-message="菜单URl不能为空">
                                    </div>


                                    <div class="form-group">
                                        <label for="name">描述</label>
                                        <input type="text" class="form-control input-lg" name="description" value="${auth.description}" placeholder="请输入菜单描述"  data-parsley-required="true" data-parsley-required-message="菜单描述不能为空">
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
            </c:when>

            <c:otherwise>
                <!-- begin row -->
                <div class="row">
                    <!-- begin col-12 -->
                    <div class="col-md-12">
                        <!-- begin panel -->
                        <div class="panel panel-inverse">
                            <div class="panel-heading">
                                <c:choose>
                                    <c:when test="${auth.id!=null}">
                                        <h3 class="panel-title">编辑按钮</h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h3 class="panel-title">新增按钮</h3>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="panel-body">

                                <form role="form" action="/sysauth/add" method="post" data-parsley-validate="true">
                                    <input type="hidden" class="form-control" name="id" value="${auth.id}">

                                    <c:choose>
                                        <c:when test="${auth.id!=null}">
                                            <div class="form-group"><label for="name">资源类型</label><input type="text" class="form-control input-lg" value="${auth.iconCls}" disabled="ture"></div>
                                            <div class="form-group"><label for="name">父级菜单</label><input type="text" class="form-control input-lg" value="${parentName}" disabled="ture"></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="form-group">
                                                <label for="name">资源类型</label>
                                                <input type="text" class="form-control input-lg" name="iconCls" value="button" disabled="ture">
                                                <input type="hidden" name="iconCls" value="button">
                                            </div>
                                            <div class="form-group">
                                                <label for="name">父级菜单</label>
                                                <select class="form-control input-lg" name="parentId" placeholder="请输入父级资源"  data-parsley-required="true" data-parsley-required-message="父级资源不能为空">
                                                    <c:forEach items="${list}" var="auth">
                                                        <option value="${auth.id}">${auth.text}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="form-group">
                                        <label for="name">按钮名称</label>
                                        <input type="text" class="form-control input-lg" name="text" value="${auth.text}" placeholder="规范格式：系统管理-用户管理（新增）"  data-parsley-required="true" data-parsley-required-message="按钮名称不能为空">
                                    </div>

                                    <div class="form-group">
                                        <label for="name">URL</label>
                                        <input type="text" class="form-control input-lg" name="url" value="${auth.url}" placeholder="请输入按钮URL"  data-parsley-required="true" data-parsley-required-message="按钮URl不能为空">
                                    </div>


                                    <div class="form-group">
                                        <label for="name">描述</label>
                                        <input type="text" class="form-control input-lg" name="description" value="${auth.description}" placeholder="请输入按钮描述"  data-parsley-required="true" data-parsley-required-message="按钮描述不能为空">
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
            </c:otherwise>
        </c:choose>

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
    if(${auth.id!=null}){
        document.title='编辑菜单';
    }
    $(document).ready(function() {
        App.init();
        Dashboard.init();
    });
</script>

</body>
</html>
