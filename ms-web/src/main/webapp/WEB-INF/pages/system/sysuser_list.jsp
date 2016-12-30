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
    <title>用户管理列表</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <jsp:include page="../common/header.jsp"></jsp:include>
    <%@include file="../common/taglib.jsp"%>
    <!-- ================== END BASE CSS STYLE ================== -->

    <!-- ================== 单独作用于本页表格td ================== -->
    <style>
        .table>tbody>tr>td {
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
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:search();" class="btn btn-xs btn-icon btn-circle btn-success"><i class="fa fa-repeat"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title"> 表格 </h4>
                    </div>

                    <%--<shiro:hasRole name="超级管理员">--%>
                    <%--<shiro:hasPermission name="新增">--%>
                        <div class="alert-info fade in">
                            <button type="button" class="btn btn-primary m-l-20 m-t-10 m-b-10" onclick="toadd()">新增</button>
                        </div>
                    <%--</shiro:hasPermission>--%>
                    <%--</shiro:hasRole>--%>


                    <div class="panel-body">
                        <div class="table-responsive">

                            <%--<button type="button" class="btn btn-link m-b-5" onclick="del(${user.id})">删除</button>--%>

                            <input type="text" class="form-control" id="username" placeholder="查询条件：账号\姓名\岗位" style="position: relative;width: 200px;top: 22px;">
                            <button type="button" class="btn btn-primary" onclick="search()" style="position: relative;top:-13px;left:223px;">查询</button>
    
                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>用户账号</th>
                                    <th>真实姓名</th>
                                    <th>密码</th>
                                    <th>岗位</th>
                                    <th>创建时间</th>
                                    <th>修改时间</th>
                                    <th>操作</th>
                                    <%--<th>编辑</th>
                                    <th>删除</th>--%>
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

<!-- ================== END PAGE LEVEL JS ================== -->

<script>

    $(document).ready(function() {
        App.init();
        TableManageFixedHeader.init();
    });


    //去往编辑页面
    function toedit(id){
        window.location.href="<%=path%>/sysuser/toedit/"+id;
    }

    //去往新增页面
    function toadd(){
        window.location.href="<%=path%>/sysuser/toadd";
    }

    //删除
    function del(id) {

        Ewin.confirm({message: "确认要删除选择的数据吗？"}).on(function (e) {
            if (!e) {
                return;
            }
            jQuery.ajax({
                type: "GET",
                url: "<%=path%>/sysuser/del/" + id,
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



    var table;
    $(document).ready(function() {
        table = $("#gadtable").DataTable( {
            "pagingType": "simple_numbers",//设置分页控件的模式
            searching: false,//屏蔽datatales的查询框
            aLengthMenu:[10],//设置一页展示10条记录
            "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
            "oLanguage": {  //对表格国际化
                "sLengthMenu": "每页显示 _MENU_条",
                "sZeroRecords": "没有找到符合条件的数据",
                //  "sProcessing": "&lt;img src=’./loading.gif’ /&gt;",
                "sInfo": "当前第 _START_ - _END_ 条　共计 _TOTAL_ 条",
                "sInfoEmpty": "木有记录",
                "sInfoFiltered": "(从 _MAX_ 条记录中过滤)",
                "sSearch": "搜索：",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"

                }
            },
            //"processing": true, //打开数据加载时的等待效果
            "serverSide": true,//打开后台分页
            "ajax": {
                "url": "/sysuser/queryTableData",
                "dataSrc": "aaData",

                "data": function ( d ) {
                    var username = $('#username').val();
                    //添加额外的参数传给服务器
                    //d.extra_search = level1;
                    d.username = username;
                    d.realName = username;
                    d.position = username;
                }
            },
            "columns": [
                { "data": "username" },
                { "data": "realName" },
                { "data": "password" },
                { "data": "position" },
                { "data": "createTime" },
                { "data": "updateTime" }

            ],
           
            "columnDefs" : [ {
                // 定义操作列,######以下是重点########
                "targets" : 6,//是操作按钮目标列
                "data" : null,
                "render" : function(data, type,row) {
                    /*var id = '"' + row.id + '"';
                    var html = "<button type='button' class='btn-link' onclick='toedit('"+id+"')'>编辑</button>"
                    html += "<button type='button' class='btn-link' onclick='del('"+id+"')'>删除</button>"
                    return html;*/
                    var id = '"' + row.id + '"';
                    var html =  "<a href='javascript:void(0);' onclick='toedit("+ id + ")' class='btn-link'>编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;"
                    html += "<a href='javascript:void(0);'   onclick='del("+ id + ")'  class='btn-link'>删除</a>"
                    return html;
                }
            } ]

        } );
    } );


    function search(){
        table.ajax.reload();
    }

</script>
</body>
</html>
