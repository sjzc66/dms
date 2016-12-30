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
    <meta charset="utf-8"/>
    <title>产品配置管理</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"></jsp:include>
    <%@include file="../common/taglib.jsp" %>
    <!-- ================== END BASE CSS STYLE ================== -->

    <!-- ================== 单独作用于本页表格td ================== -->
    <style>
        .table > tbody > tr > td {
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
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default"
                               data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i
                                    class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger"
                               data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">产品列表</h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <table class="table">
                                <tr>
                                    <td><span style="position: relative;top: 22px;">产品编号</span>
                                        <input type="text" class="form-control" id="prductId" placeholder="查询条件：产品编号"
                                               style="width: 150px;height: 30px;position: relative;left:60px;"></td>

                                    <td><span style="position: relative;top: 22px;">产品名称</span>
                                        <input type="text" class="form-control" id="productName" placeholder="查询条件：产品名称"
                                               style="width: 150px;height: 30px;position: relative;left:60px;"></td>
                                    <td>
                                        <button style="position: relative;top: 12px;" type="button" class="btn btn-primary" onclick="search()">查询</button>
                                        <button style="position: relative;top: 12px;left:40px;" type="button" class="btn btn-primary" onclick="toadd()">新增</button>
                                    </td>

                                </tr>
                            </table>


                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>产品编号</th>
                                    <th>产品名称</th>
                                    <th>金融产品名称</th>
                                    <th>期数</th>
                                    <th>月利率</th>
                                    <th>年利率</th>
                                    <th>创建时间</th>
                                    <th>创建人</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>

                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-12 -->
        </div>
        <!-- end row -->
    </div>
    <!-- end #content -->

</div>
<!-- end page container -->
<jsp:include page="../common/footer.jsp"/>
<script src="/static/pages/product/list.js"></script>
<!-- ================== END PAGE LEVEL JS ================== -->
<script>
    //去往编辑页面
    function toedit(id){
        window.location.href="<%=path%>/product/toedit/"+id;
    }

    //去往新增页面
    function toadd(){
        window.location.href="<%=path%>/product/toadd";
    }

    //删除
    function del(id) {

        Ewin.confirm({message: "确认要删除选择的数据吗？"}).on(function (e) {
            if (!e) {
                return;
            }
            jQuery.ajax({
                type: "GET",
                url: "<%=path%>/product/del/" + id,
                dataType: "json",
                success: function (data) {
                    if (data.success == true) {
                        alert('删除成功!');
                    } else {
                        alert('删除失败!');
                    }
                    location.reload();
                }
            });
        });
    }
</script>
</body>
</html>


