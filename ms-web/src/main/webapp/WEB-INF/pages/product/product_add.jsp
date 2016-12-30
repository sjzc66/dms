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
    <title>新增产品</title>
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
        <%--<h1 class="page-header"> 在很久很久以前 <small>......</small></h1>--%>
        <!-- end page-header -->

        <!-- begin row -->
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <c:choose>
                                <c:when test="${product.id!=null}">
                                    <h3 class="panel-title">编辑</h3>
                                </c:when>
                                <c:otherwise>
                                    <h3 class="panel-title">新增</h3>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="panel-body">

                            <form role="form" action="/product/add" method="post" data-parsley-validate="true">
                                <input type="hidden" class="form-control" name="id" value="${product.id}">
                                <div class="form-group">
                                    <label for="name">
                                        产品编号<span id="spanMessage"></span>
                                    </label>
                                    <c:choose>
                                        <c:when test="${product.prductId!=null}">
                                            <input type="text" class="form-control input-lg" name="prductId" value="${product.prductId}" disabled="ture">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="form-control input-lg" id="prductId" name="prductId" placeholder="请输入产品编号" data-parsley-required="true" data-parsley-required-message="账号不能为空">
                                        </c:otherwise>
                                    </c:choose>

                                </div>

                                <div class="form-group">
                                    <label for="name">产品名称</label>
                                    <input type="text" class="form-control input-lg" name="productName" value="${product.productName}" placeholder="请输入密码"  data-parsley-required="true" data-parsley-required-message="密码不能为空">
                                </div>

                                <div class="form-group">
                                    <label for="name">期数</label>
                                    <input type="text" class="form-control input-lg" name="period" value="${product.period}" placeholder="请输入期数">
                                </div>

                                <div class="form-group">
                                    <label for="name">月利率</label>
                                    <input type="text" class="form-control input-lg" name="monthRate" value="${product.monthRate}"  onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  placeholder="请输入月利率">
                                </div>
                                <div class="form-group">
                                    <label for="name">年利率</label>
                                    <input type="text" class="form-control input-lg" name="yearRate" value="${product.yearRate}"  onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" placeholder="请输入年利率">
                                </div>
                                <div class="form-group">
                                    <label for="name">适用产品</label>
                                    <input type="text" class="form-control input-lg" name="applyProduct" value="${product.applyProduct}" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="请输入适用产品">
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

    $(document).ready(function () {
        App.init();
        TableManageFixedHeader.init();
    });

    if(${product.id!=null}){
        document.title='编辑产品';
    }

</script>
</body>
</html>
