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
    <title>面签补件</title>
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
                        <h4 class="panel-title"> 表格 </h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <table class="table">
                                <tr>
                                    <td>
                                        <button style="position: relative;top: 12px;" type="button" class="btn btn-primary" onclick="search()">查询</button>
                                    </td>
                                    <td><span style="position: relative;top: 22px;">单号</span>
                                        <input type="text" class="form-control" id="orderId" placeholder="查询条件：单号"
                                                  style="width: 120px;height: 30px;position: relative;left:40px;"></td>
                                    <td><span style="position: relative; top: 22px;">手机号</span>
                                        <input type="text" class="form-control" id="phone" placeholder="查询条件：手机号"
                                                  style="width: 120px;height: 30px;position: relative;left:40px;"></td>
                                    <td><span style="position: relative; top: 22px;">姓名</span>
                                        <input type="text" class="form-control" id="username" placeholder="查询条件：姓名"
                                                  style="width: 120px;height: 30px;position: relative;left:40px;"></td>
                                    <td><span style="position: relative; top: 22px;">照片上传状态</span>
                                        <select id ="approvalStatus" class="form-control" style="width: 120px;height: 30px;position: relative;left:75px;">
                                            <option value="">==全部==</option>
                                            <option value="0">没有上传照片</option>
                                            <option value="1">已经上传照片</option>
                                            <option value="2">重新上传照片</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>



                            <table id="gadtable" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>单号</th>
                                    <th>申请时间</th>
                                    <th>手机号码</th>
                                    <th>进件产品</th>
                                    <th>用户姓名</th>
                                    <th>身份证</th>
                                    <th>客户类型</th>
                                    <th>照片上传状态</th>
                                    <th>市场推荐码</th>
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

<!-- ================== END PAGE LEVEL JS ================== -->

<script>

    $(document).ready(function () {
        App.init();
        TableManageFixedHeader.init();
    });

    var table;
    $(document).ready(function () {
        table = $("#gadtable").DataTable({
            "pagingType": "simple_numbers",//设置分页控件的模式
            searching: false,//屏蔽datatales的查询框
            aLengthMenu: [10],//设置一页展示10条记录
            "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
            "oLanguage": {  //对表格国际化
                "sLengthMenu": "每页显示 _MENU_条",
                "sZeroRecords": "没有找到符合条件的数据",
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
            "serverSide": true,//打开后台分页
            "ajax": {
                "url": "/facepatch/queryTableData",
                "dataSrc": "aaData",
                "data": function (d) {
                    var orderId = $('#orderId').val();
                    var username = $('#username').val();
                    var phone = $('#phone').val();
                    var approvalStatus = $('#approvalStatus').val();
                    //添加额外的参数传给服务器
                    d.orderId = orderId;
                    d.realName = username;
                    d.phone = phone;
                    d.approvalStatus = approvalStatus;
                }
            },
            "columns": [
                {"data": "orderId"},
                {"data": "applicationTime"},
                {"data": "phone"},
                {"data": "productType",
                    "render":function(data) {
                        switch (data){
                            case 1:return "随手借"; break;
                            case 2:return "白条";     break;
                            case 3:return "商城";     break;
                            default:return "未知状态"
                        }
                    }
                },//产品类型
                {"data": "username"},
                {"data": "idNumber"},
                {"data": "customerType",
                    "render":function(data) {
                        switch (data){
                            case 0:return "学生";     break;
                            case 1:return "白领";     break;
                            default:return "未知状态"
                        }
                    }
                },//客户类型
                {"data": "approvalStatus",
                    "render":function(data) {
                        switch (data){
                            case 0:return "没有上传";     break;
                            case 1:return "已经上传";     break;
                            case 2:return "再次上传";     break;
                            default:return "未知状态"
                        }
                    }
                },//上传状态
                {"data": "recommendCode"}
            ],

            "columnDefs": [{
                // 定义操作列
                "targets": 9,//操作按钮目标列标
                "data": null,
                "render": function (data, type, row) {
                    var id = '"' + row.id + '"';
                    var html = "<a href='javascript:void(0);' onclick='todetail(" + id + ")' class='btn-link'>证件补充</a>&nbsp;&nbsp;&nbsp;&nbsp;"
                    return html;
                }
            }]

        });
    });


    //去往认证补充页面
    function todetail(id){
        window.location.href="<%=path%>/facepatch/todetail/"+id;
    }

    function search() {
        table.ajax.reload();
    }

</script>
</body>
</html>
